import socket 

host = socket.gethostname()
port = 1337

serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serverSocket.bind((host,port))
serverSocket.listen(3)

conn, address = serverSocket.accept()
with conn:
    print('Connected from: ', address)
    while True:
        data = conn.recv(1024)
        if not data:
            break
        conn.sendall(data)