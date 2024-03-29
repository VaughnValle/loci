from socket import *
import base64
# Choose a mail server (e.g. NYU. mail server) and call it mailserver
# Code Start dig vaughnvalle.me MX # Code End
mailserver = "route1.mx.cloudflare.net" #Code Start #Code End
serverPort = 25
# Create socket and establish TCP connection with mailserver
# Code Start
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((mailserver, serverPort))
# Code End
tcp_resp = clientSocket.recv(1024).decode()
print(tcp_resp)

# Send HELO command to begin SMTP handshake.
heloCommand = 'HELO Alice\r\n'
clientSocket.send(heloCommand.encode())
helo_resp = clientSocket.recv(1024).decode()
print(helo_resp)

# Send MAIL FROM command and print response.
# Code Start
msg = "MAIL FROM:<vqv9731@nyu.edu>\r\n"
clientSocket.send(msg.encode())
tcp_resp = clientSocket.recv(1024)
print(tcp_resp)
# Code End
# Send RCPT TO command and print server response.
# Code Start
msg = "RCPT TO:<mail@vaughnvalle.me>\r\n"
clientSocket.send(msg.encode())
tcp_resp = clientSocket.recv(1024)
print(tcp_resp)
# Code End
# Send DATA command and print server response.
# Code Start
msg = "DATA\r\n"
clientSocket.send(msg.encode())
tcp_resp = clientSocket.recv(1024)
print(tcp_resp)
# Code End
# Send email data.
# Code Start
msg = """From: vqv9731@nyu.edu
To: mail@vaughnvalle.me\n
Subject: SMTP via Python Sockets\n
This is a test email from your python socket program\r\n"""
clientSocket.send(msg.encode())
# Code End
# Send message to close email message.
# Code Start
msg = "\r\n.\r\n"
clientSocket.send(msg.encode())
tcp_resp = clientSocket.recv(1024)
print(tcp_resp)
# Code End
# Send QUIT command and get server response.
# Code Start
msg = "QUIT\r\n"
clientSocket.send(msg.encode())
# Code End
clientSocket.close()
