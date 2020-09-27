
import socket
import sys
import re
import time

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_name = 'localhost'
server_address = (server_name, 5002)
print('starting up on {} port {}'.format(*server_address))
sock.bind(server_address)
sock.listen(1)
colorRegex = re.compile(r"\d{3},\d{3},\d{3}")
while True:
    print('waiting for a connection')
    connection, client_address = sock.accept()
    try:
        print('client connected:', client_address)
        while True:
            data = connection.recv(64)
            print('received {!r}'.format(data))
            if data: 
                
                if ( colorRegex.match(data.decode("UTF-8")) ):
                    color = data.split(",")
                    connection.send(b"0")
                else:
                    connection.send(b"1")
                    
            else:
                break
    finally:
        connection.close()