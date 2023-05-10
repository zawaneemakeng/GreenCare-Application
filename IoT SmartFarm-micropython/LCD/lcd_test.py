from machine import Pin,SoftI2C
from i2c_lcd import I2cLcd
import time
i2c = SoftI2C(scl = Pin(22),sda = Pin(21),freq = 10000)
#print('i2c Address :',hex(i2c.scan()[0]))
lcd = I2cLcd(i2c,0x3f,2,16)
#lcd.putstr('zawanee\nmakeng')

b = bytearray([
  0x00,
  0x00,
  0x0A,
  0x1F,
  0x1F,
  0x0E,
  0x04,
  0x00])
fr = bytearray([
  0x1F,
  0x1F,
  0x18,
  0x1F,
  0x1F,
  0x18,
  0x18,
  0x18])
bb = bytearray([
   0x1F,
  0x19,
  0x19,
  0x1F,
  0x1F,
  0x19,
  0x19,
  0x1F])
lcd.custom_char(0,b) #register custom
lcd.custom_char(1,fr)
lcd.custom_char(2,bb)

'''
lcd.move_to(2,0)
lcd.putchar(chr(1))
lcd.move_to(4,0)
lcd.putchar(chr(0))
lcd.move_to(6,0)
lcd.putchar(chr(2))
lcd.move_to(2,1)
lcd.putstr('zawanee')
'''
for i in range(5):
    lcd.move_to(2,0)
    lcd.putchar(chr(1))
    lcd.move_to(4,0)
    lcd.putchar(chr(0))
    lcd.move_to(6,0)
    lcd.putchar(chr(2))
    lcd.move_to(2,1)
    time.sleep(3)
    lcd.clear()
    lcd.move_to(5,1)
    lcd.putstr('zawanee')
    time.sleep(3)
'''
#blaclihgt on/off

for i in range(10):
    lcd.backlight_off()
    time.sleep(2)
    lcd.backlight_on()
    time.sleep(2)
'''
#display on/off
'''
for i in range(10):
    lcd.display_off()
    time.sleep(2)
    lcd.display_on()
    time.sleep(2)
'''
#cursor on/off
'''
lcd.move_to(10,1)
for i in range(10):
    lcd.blink_cursor_off()
    time.sleep(2)
    lcd.blink_cursor_on()
    time.sleep(2)
'''
