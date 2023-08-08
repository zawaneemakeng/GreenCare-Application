from datetime import datetime
import time
import socket
import _thread

global led_status
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = ''
port = 80
s.bind((host,port))
s.listen(5)
while True :
    now = datetime.now()
    current_time = now.strftime("%H:%M")    
    client, addr = s.accept()
    print('connection from: ', addr)
    data = client.recv(1024).decode('utf-8')
    print([data])
    check = data.split()[1].replace('/','')
    print("CHECK : {}".format(check)) 
    # stamp = '12:32:00'
    try :
        if current_time == check :
            print("ok JAAA {}".format(current_time))
            client.close()
    except :
        pass
   
    


# while True:
#     now = datetime.now()
#     stamp = '12:32:00'
#     current_time = now.strftime("%H:%M:%S")
#     if stamp == current_time:
#         print("ok JAAA")
#         break

# current_time = now.strftime("%H:%M:%S")
# print("Current Time =", current_time)