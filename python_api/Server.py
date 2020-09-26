
import socket
import re

HOST = 'localhost'                 # Symbolic name meaning all available interfaces
PORT = 50007              # Arbitrary non-privileged port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)
conn, addr = s.accept()
print 'Connected by', addr
colorRegex = re.compile('\d{3},\d{3},\d{3}')



while 1:
    data = conn.recv(1024)
    if ( colorRegex.match(data) ):
         color = data.split(",")
         conn.sendall("0")
    else:
        conn.sendall("1")
        
    if not data: break
    conn.sendall(data)
conn.close()