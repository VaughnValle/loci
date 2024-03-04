from socket import *

#Create a TCP server socket
#Code Start
sock = socket(AF_INET, SOCK_STREAM)
sock.bind(('', 5555))
sock.listen(1)
#Code End

while True:
    #Establish the connection
    print("The server is ready to receive")
    connectionSocket, addr = sock.accept()
    try:
        message = connectionSocket.recv(1024).decode()
        filename = message.split()[1]
        f = open("./html_files/" + filename[1:])
        output = f.read()

        #Send HTTP OK and the Set-Cookie header into the socket
        # set the cookie to whatever value you'd like
        #Code Start
        #connectionSocket.send("HTTP/1.1 200 OK\r\nSet-Cookie: session=1\r\n\r\n".encode())
        connectionSocket.send(b'HTTP/1.1 200 OK\r\n')
        #Code End
        #Send the content of the requested file to the client
        for i in range(0, len(output)):
            connectionSocket.send(output[i].encode())
        # Close the socket
        #Code Start
        connectionSocket.close()
        #Code End
    except IOError:
        #Send HTTP NotFound response
        #Code Start
        #connectionSocket.send(b'HTTP/1.1 404 Not Found\r\n')
        #Code End
        # Close the socket
        #Code Start
        connectionSocket.close()
        #Code End
serverSocket.close()
