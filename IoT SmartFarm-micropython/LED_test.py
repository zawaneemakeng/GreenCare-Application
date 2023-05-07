from machine import Pin
import time

led = Pin(23, Pin.OUT)

for i in range(20):
    led.on()
    time.sleep(1)
    led.off()
    time.sleep(1)
