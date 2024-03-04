from socket import *
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', 8888))
serverSocket.listen(1)
#Code End

while True:
    #Establish the connection
    #print("The server is ready to receive")
    connectionSocket, addr = serverSocket.accept() #Code Start #Code End
    try:
        message = connectionSocket.recv(1024).decode()
        filename = message.split()[1]
        f = open("./html_files/" + filename[1:])
        outputdata = f.read()
        connectionSocket.send('HTTP/1.1 200 OK\n'.encode())
        connectionSocket.send('Set-Cookie: mycookie=rahhhhhhh\n\n'.encode())
        for i in range(0, len(outputdata)):
            connectionSocket.send(outputdata[i].encode())

        connectionSocket.close()
    except IOError:
        connectionSocket.send('HTTP/1.1 404 Not Found\n'.encode())
        print("404 Not Found")
        connectionSocket.close()
serverSocket.close()
