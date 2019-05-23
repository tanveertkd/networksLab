import socket

host = socket.gethostname()
port = 1337

clientSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
clientSocket.connect((host, port))
clientSocket.sendall(b'Hello')
data = clientSocket.recv(1024)
print('Recieved: ', repr(data))