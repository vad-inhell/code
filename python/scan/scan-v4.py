#!/usr/bin/env python
#invaiders must die
#copyleft inhell 2009
#vad@tXXmoXa.su

import threading
import socket
import time
from datetime import datetime
from array import array

start_time = datetime.now ()
out_file = result.csv
sourceFile=open(out_file, 'w')

print('start')

port_list = array ('i',[443,25,80 ])

with open("targets.lst") as file:
    host_list = [row.strip() for row in file]

def scan_ip(host, port):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(0.5)

    try:
        s.connect((host, port))
        print("Host: " + host + "Open port: " + str(port)
        print('At host: ', host, 'Port :', str(port), "is open", file=sourceFile)
        s.close
    except:
        pass

count = 0
for ip in host_list:
    count = count + 1

    for port in port_list:
        time.sleep(0.0005)
        t = threading.Thread(target=scan_ip, args=(ip, port))
        t.daemon = True
        t.start()

    if count == 3:
        print("\nTime OUT")
        count = 0
        time.sleep(10)

sourceFile.close()

t.join()


end_time = datetime.now()
print('Прошло:{}'.format(end_time - start_time))
