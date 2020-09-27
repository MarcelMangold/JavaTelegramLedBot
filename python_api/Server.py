
import socket
import sys
import re
import time
import LedApi as api

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_name = 'localhost'
server_address = (server_name, 5002)
print('starting up on {} port {}'.format(*server_address))
sock.bind(server_address)
sock.listen(1)
colorRegex = re.compile(r"\d{1,3},\d{1,3},\d{1,3}")
while True:
    print('waiting for a connection')
    connection, client_address = sock.accept()
    try:
        print('client connected:', client_address)
        data = connection.recv(64)
        print('received {!r}'.format(data))
        if data: 
            if (colorRegex.match(data.decode("UTF-8")) ):
                colorString = data.split(",")
                colorInt = [int(numeric_string) for numeric_string in colorString]
                api.changeColor(colorInt)
                connection.send(b"0")
            elif (data.decode("UTF-8") == "off"):
                api.setLedsOff()
                connection.send(b"0")
            elif (data.decode("UTF-8") == "rainbow"):
                api.rainbow_cycle( wait=0.1)
                connection.send(b"0")
            else:
                connection.send(b"1")         
   # except:
    #       connection.send(b"1")
    finally:
        connection.close()