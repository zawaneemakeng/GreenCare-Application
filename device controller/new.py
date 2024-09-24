from machine import Pin,ADC
import ntptime
import network
import time
import utime
import socket
import _thread
import network
import urequests as requests
import json

###########WIFI###################
time.sleep(2)
wifi = 'prickthai'
password = 'bb090708'
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
time.sleep(2) 
wlan.connect(wifi, password)
time.sleep(2)
status = wlan.isconnected() # True/False
ip ,_ ,_ ,_ = wlan.ifconfig()
print(ip)

#ีuser requests 
plantID = 0
setmoisture = 0
starttime = 0
endtime = 0

#LED
led_1 = Pin(12,Pin.OUT)
led_2 = Pin(14,Pin.OUT)

#RELAY
pump = Pin(23,Pin.OUT)

#Water Level
distance_cm = 10

# Soil Moisture
soil = ADC(Pin(35))
m = 100

min_moisture=0
max_moisture=4095

soil.atten(ADC.ATTN_11DB)       #Full range: 3.3v
soil.width(ADC.WIDTH_12BIT)


def check_soil():
    global moisture
    while True:
        try:
            soil.read()
            time.sleep(2)
            m = (max_moisture-soil.read())*100/(max_moisture-min_moisture)
            moisture = 'Soil Moisture: {:.1f} %'.format(m)
            print("Soil Moisture: " + "%.1f" % m +"% (adc: "+str(soil.read())+")")
            time.sleep(5)
        except:
            pass
        
def post_soil():
    while True:
        try:
            url = "http://192.168.2.35:8000/api/post-soilmoisture"
            data= {"soilmoisture": moisture,"title": "FARM G1"}
            r = requests.post(url, json=data)
            result = json.loads(r.content)
            print(result)
            time.sleep(15)
        except:
            pass


def check_water_level():
    while True:
        print("Distance : {:.0f} cm".format(distance_cm-3))
        time.sleep(5)
        
def post_waterlevel():
    while True:
        try:
            url = "http://192.168.2.35:8000/api/post-waterlevel"
            data= {"waterl_remaining":distance_cm,"title": "FARM G1"}
            r = requests.post(url, json=data)
            result = json.loads(r.content)
            print(result)
            time.sleep(10)
        except:
            pass 

led_on = '''
<!doctype html>
  <body>
  <h1>LED ON</h1>
  </body>
</html>
'''
led_off = '''
<!doctype html>
  <body>
  <h1>LED OFF</h1>
  </body>
</html>
'''
pump_on = '''
<!doctype html>
  <body>
  <h1>PUMP ON</h1>
  </body>
</html>
'''
pump_off = '''
<!doctype html>
  <body>
  <h1>PUMP OFF</h1>
  </body>
</html>
'''

global led_status
led_status = 'OFF'
global  pump_status
pump_status = 'OFF'
        
def runserverDevice():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = ''
    port = 80
    s.bind((host,port))
    s.listen(5)
    while True:
        client, addr = s.accept()
        #print('connection from: ', addr)
        data = client.recv(1024).decode('utf-8')
        print([data])
        try:
            check = data.split()[1].replace('/','').replace('?','')
            print('CHECK:',check)
            if check != '':
                split_result = check.split(':')
                if len(split_result) > 1:
                    if split_result[0] == 'plant-id':
                        plantID = int(split_result[1])
                        print("plantID---------{}".format(plantID))
                        client.close()
                    if split_result[0] == 'setmoiture':
                        setmoisture = int(split_result[1])
                        print("setmoisture---------{}".format(setmoisture))
                        client.close()
                    if split_result[0] == 'starttime':
                        starttime = int(split_result[1])
                        print("starttime---------{}".format(starttime))
                        client.close()
                    if split_result[0] == 'endtime':
                        endtime = int(split_result[1])
                        print("endtime---------{}".format(endtime))
                        client.close()
                if check == 'LED=ON':
                    client.send(led_on)
                    led_status = 'ON'
                    print('------------LED : {}------------'.format(led_status))
                    client.close()
                elif check == 'LED=OFF':
                    client.send(led_off)
                    led_status = 'OFF'
                    print('------------LED : {}------------'.format(led_status))
                    client.close()
                elif check == 'PUMP=ON':
                    client.send(pump_on)
                    pump_status = 'ON'
                    print('------------PUMP : {}------------'.format(pump_status))
                    client.close()
                elif check == 'PUMP=OFF':
                    client.send(pump_off)
                    pump_status = 'OFF'
                    print('------------PUMP : {}------------'.format(pump_status))
                    client.close()
        except:
            pass 

def pump_auto():
    while True:
        if moisture < 40:
            pump.value(0)
            print('{}: WATERPUMP ON (AUTO)')
            time.sleep(5)

def led_auto():
    global led_status
    led_name = 'LED'
    try:
        while True:
              time.localtime()
              time.sleep(3)
              ntptime.settime()
              now = time.localtime()
              settime = "{}:{}".format(now[3]+7,now[4])
              print(now)
              print(settime)
              time.sleep(5)
    except:
        pass
          
#_thread.start_new_thread(runserverDevice())


#_thread.start_new_thread(pump_auto,())
#_thread.start_new_thread(led_auto(),())


_thread.start_new_thread(check_soil,())
#_thread.start_new_thread(check_water_level,())


#_thread.start_new_thread(post_soil,())
#_thread.start_new_thread(post_waterlevel,())