from socket import *
HOST = 'localhost'
PORT = 12345
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((HOST, PORT))
filename = input('Retrieve a file: ')
clientSocket.send(filename.encode())
response = clientSocket.recv(1024)
print ("Server Response: " + response.decode())
clientSocket.close()
