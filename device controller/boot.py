import ntptime
from hcsr04 import HCSR04
from machine import Pin, ADC, time_pulse_us
import network
import time
import utime
import socket
import _thread
import network
import urequests as requests
import json

# time internet protocal
ntptime.host = "1.th.pool.ntp.org"
gettime = ''
current_hour = 0
current_minute = 0
# user req
plant_id = 0
setmoisture = 40
setstarttime = '20:30'
setendtime = '5:50'
# Water Level
waterlevel = HCSR04(trigger_pin=5, echo_pin=18, echo_timeout_us=10000)
current_waterlevel = 0
# SoilMoisture
soil_moisture = ADC(Pin(35))
moisture = 0
min_moisture = 0
max_moisture = 4095
# LED
led01 = Pin(19, Pin.OUT)
led02 = Pin(17, Pin.OUT)
led01.off()
led02.off()
# Fill up the water tank
led_red = Pin(22, Pin.OUT)
led_red.off()

# PUMP
pump = Pin(23, Pin.OUT)
pump.value(1)
wifi = 'wifiname'
password = 'your_password_wifi'
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
time.sleep(2)
wlan.connect(wifi, password)
time.sleep(2)
status = wlan.isconnected()  # True/False
ip, _, _, _ = wlan.ifconfig()
if status == True:
    led_red.on()
    time.sleep(2)
    led_red.off()


def checkTime():
    global current_hour
    global current_minute
    global gettime
    while True:
        try:
            time.localtime()
            time.sleep(1)
            ntptime.settime()
            time.sleep(1)
            now = time.localtime()
            current_hour = now[3]+7
            current_minute = now[4]
            gettime = '{}:{}'.format(current_hour, current_minute)
            print(gettime)
            time.sleep(5)
        except:
            pass


def runServer():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = ''
    port = 80
    s.bind((host, port))
    s.listen(5)
    while True:
        global setstarttime
        global setendtime
        global setmoisture
        global plant_id
        client, addr = s.accept()
        # print('connection from: ', addr)
        data = client.recv(1024).decode('utf-8')
        # print([data])
        try:
            check = data.split()[1].replace('/', '').replace('?', '')
            print('CHECK:', check)
            if check != '':
                split_result = check.split(':')
                if len(split_result) > 1:
                    if split_result[0] == 'plant-id':
                        plant_id = int(split_result[1])
                        print("plantID == {}".format(plant_id))
                        client.close()
                    if split_result[0] == 'setmoiture':
                        setmoisture = int(split_result[1])
                        print("setmoisture == {}".format(setmoisture))
                        client.close()
                    if split_result[0] == 'starttime':
                        setstarttime = '{}:{}'.format(
                            split_result[1], split_result[2])
                        print("starttime == {}".format(setstarttime))
                        client.close()
                    if split_result[0] == 'endtime':
                        setendtime = "{}:{}".format(
                            split_result[1], split_result[2])
                        print("endtime == {}".format(setendtime))
                        client.close()
                if check == 'LED=ON':
                    led01.on()
                    led02.on()
                    print('------------LED : ON------------')
                    client.close()
                elif check == 'LED=OFF':
                    led01.off()
                    led02.off()
                    print('------------LED : OFF------------')
                    client.close()
                elif check == 'PUMP=ON':
                    pump.value(0)
                    print('------------PUMP :ON------------')
                    client.close()
                elif check == 'PUMP=OFF':
                    pump.value(1)
                    print('------------PUMP : OFF------------')
                    client.close()
        except:
            pass


def openPUMP():
    while True:
        try:
            if moisture <= setmoisture:
                if (current_hour >= 6 and current_hour <= 8) or (current_hour >= 16 and current_hour <= 18):
                    print('WATERPUMP ON')
                    pump.value(0)
                    time.sleep(2)
                    pump.value(1)
                    postPUMP(True)

            else:
                pump.value(1)
                print('WATERPUMP OFF')
                postPUMP(False)
            time.sleep(10)

        except:
            pass


def openLED():
    while True:
        try:
            if gettime == setstarttime:
                print("-------TURN ON LED")
                led01.on()
                led02.on()
                postLED(True)
            elif gettime == setendtime:
                print("--------TURN OFF LED")
                led01.off()
                led02.off()
                postLED(False)
            time.sleep(15)
        except:
            pass


def checkSoilMoisture():
    while True:
        try:
            global moisture
            read = soil_moisture.read()
            m = (max_moisture-read)*300/(max_moisture-min_moisture)
            newm = "{:.0f}".format(m)
            moisture = float(newm)
            print(moisture)
            time.sleep(10)
        except:
            pass


def checkWaterLevel():
    global current_waterlevel
    while True:
        try:
            distance = waterlevel.distance_cm()
            newwater = "{:.0f}".format(distance)
            getwaterlevel = float(newwater)
            if getwaterlevel == 18:
                current_waterlevel = 0.00
            elif getwaterlevel == 17:
                current_waterlevel = 10.00
            elif getwaterlevel == 16:
                current_waterlevel = 20.00
            elif getwaterlevel == 15:
                current_waterlevel = 25.00
            elif getwaterlevel == 14:
                current_waterlevel = 30.00
            elif getwaterlevel == 13:
                current_waterlevel = 35.00
            elif getwaterlevel == 12:
                current_waterlevel = 40.00
            elif getwaterlevel == 11:
                current_waterlevel = 45.00
            elif getwaterlevel == 10:
                current_waterlevel = 50.00
            elif getwaterlevel == 9:
                current_waterlevel = 55.00
            elif getwaterlevel == 8:
                current_waterlevel = 60.00
            elif getwaterlevel == 7:
                current_waterlevel = 65.00
            elif getwaterlevel == 6:
                current_waterlevel = 70.00
            elif getwaterlevel == 5:
                current_waterlevel = 75.00
            elif getwaterlevel == 4:
                current_waterlevel = 80.00
            elif getwaterlevel == 3:
                current_waterlevel = 85.00
            elif getwaterlevel == 2:
                current_waterlevel = 90.00
            elif getwaterlevel == 1:
                current_waterlevel = 95.00
            elif getwaterlevel == 0:
                current_waterlevel = 100.00
            print("น้ำคงเหลือ {} %".format(current_waterlevel))
            time.sleep(12)
        except:
            pass


def fillUpWater():
    while True:
        try:
            if current_waterlevel <= 5:
                print("Fill up the water tank")
                for i in range(10):
                    led_red.on()
                    time.sleep(0.5)
                    led_red.off()
                    time.sleep(0.5)
            time.sleep(3600)
        except:
            pass
        time.sleep(20)


def postLED(statusLED):
    try:
        url = "http://192.168.233.152:8000/api/post-ledplant"
        data = {"plant": plant_id, "status": statusLED}
        r = requests.post(url, json=data)
        result = json.loads(r.content)
    except:
        pass


def postPUMP(statusPUMP):
    try:
        url = "http://----------:8000/api/post-waterplant"
        data = {"plant": plant_id, "status": statusPUMP}
        r = requests.post(url, json=data)
        result = json.loads(r.content)
    except:
        pass


def postSoilMoisture():
    while True:
        try:
            url = "http://------:8000/api/post-soilmoisture"
            data = {"plant": plant_id, "soilmoisture": moisture}
            r = requests.post(url, json=data)
            result = json.loads(r.content)
            print(result)
            time.sleep(8)
        except:
            pass


def postWaterLevel():
    while True:
        try:
            url = "http://192.168.233.152:8000/api/post-waterlevel"
            data = {"plant": plant_id, "water_remaining": current_waterlevel}
            r = requests.post(url, json=data)
            result = json.loads(r.content)
            print(result)
            time.sleep(7)
        except:
            pass


_thread.start_new_thread(runServer, ())
_thread.start_new_thread(checkTime, ())
_thread.start_new_thread(fillUpWater, ())
_thread.start_new_thread(checkSoilMoisture, ())
_thread.start_new_thread(checkWaterLevel, ())
_thread.start_new_thread(openPUMP, ())
_thread.start_new_thread(openLED, ())
_thread.start_new_thread(postWaterLevel, ())
_thread.start_new_thread(postSoilMoisture, ())
