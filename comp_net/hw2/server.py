from socket import * #Create a TCP server socket
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', 1111))
serverSocket.listen(1)

while True:
    #Establish the connection
    print("The server is ready to receive") 
    connectionSocket, addr = serverSocket.accept()
    try:
        message = connectionSocket.recv(1024).decode() 
        filename = message.split()[1]
        f = open("./html_files/" + filename[1:]) 
        outputdata = f.read()
        connectionSocket.send(b'HTTP/1.1 200 OK\n')
        #connectionSocket.send('Set-Cookie: user=admin\n\n'.encode())
        connectionSocket.send(b'Set-Cookie: user=admin\n\n')
        for i in range(0, len(outputdata)):
            connectionSocket.send(outputdata[i].encode()) 

        connectionSocket.close()
    except IOError:
        connectionSocket.send(b'HTTP/1.1 404 Not Found\n')
        connectionSocket.close()
serverSocket.close()
