from machine import Pin,SoftI2C
from i2c_lcd import I2cLcd
import network
import time
import socket
import _thread

#LCD
i2c = SoftI2C(scl = Pin(22),sda = Pin(21),freq = 10000)
lcd = I2cLcd(i2c,0x3f,2,16)

time.sleep(1)
text = 'Starting...'
lcd.putstr(text)
#LED
led = Pin(23,Pin.OUT)
led.off()

#WIFI
wifi = '--------'
password = '---------'
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
time.sleep(2)
wlan.connect(wifi,password)
time.sleep(2)
status = wlan.isconnected()
ip,_,_,_ = wlan.ifconfig()

if status == True:
    lcd.clear()
    text = 'IP{}'.format(ip)
    lcd.putstr(text)
    time.sleep(2)
    lcd.clear()
    text = 'IP{}\n   Connected'.format(ip)
    lcd.putstr(text)
else:
    lcd.clear()
    text = ' Disconnect'
    lcd.putstr(text)



html_on = '''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>ESP32 - Status</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/pricing/">
  <link href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  </head>
  <body>
  <div class="container">
  <form>
    <center>
      <img src="https://raw.githubusercontent.com/UncleEngineer/MicroPython-IoT/main/light-bulb-on.png" width="300">
     <h3>LED 1</h3>
          <button  class="btn btn-primary" name="LED" value="ON" type="submit">ON</button>&nbsp;
        <button  class="btn btn-danger" name="LED" value="OFF" type="submit">OFF</button>
    </center>
   </form>
  </div>

    
  </body>
</html>

'''
html_off = '''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>ESP32 - Status</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/pricing/">
  <link href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  </head>
  <body>
  <div class="container">
  <form>
    <center>
      <img src="https://img.icons8.com/?size=512&id=UZg_20c5bu5H&format=png" width="300">
     <h3>LED 1</h3>
          <button  class="btn btn-primary" name="LED" value="ON" type="submit">ON</button>&nbsp;
        <button  class="btn btn-danger" name="LED" value="OFF" type="submit">OFF</button>
    </center>
   </form>
  </div>

    
  </body>
</html>

'''
global led_status
def runserver():
    global led_status
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM) #UDP EX:==metting TCP inet
    host = ''
    port = 80
    s.bind((host,port))
    s.listen(5)

    led_status = 'OFF'

    while True:
        client,addr = s.accept()
        print('connection from : ',addr)
        data = client.recv(1024).decode('utf-8')
        print([data])
        
        try:
            check = data.split()[1].replace('/','').replace('?','')
            print(check)
            
            if check != '':
                led_name,led_value = check.split('=')
                if led_value =='ON':
                    print('TURN ON LED')
                    led.on()
                    client.send(html_on)
                    client.close()
                    lcd.clear()
                    text = 'LED ON'
                    lcd.putstr(text)
                    led_status = 'ON'
                elif led_value =='OFF':
                    print('TURN OFF LED')
                    led.off()
                    client.send(html_off)
                    client.close()
                    lcd.clear()
                    text = 'LED OFF'
                    lcd.putstr(text)
                    
            else:
                if led_status == 'OFF':
                    client.send(html_off)
                else:
                    client.send(html_on)        
                
        except:
            pass
    
def loop_led():
    global led_status
    for i in range(50):
        led.on()
        text = 'LED ON (AUTO)'
        lcd.putstr(text)
        led_status = 'ON'
        time.sleep(10)
        led.off()
        lcd.clear()
        text = 'LED OFF (AUTO)'
        lcd.putstr(text)
        led_status = 'OFF'
        time.sleep(10)
        
_thread.start_new_thread(runserver,())
_thread.start_new_thread(loop_led,())

