
# Types
### POST
- form/user input send from client to server via body of [[HTTP request]]
### GET

^d3af98

- used to send data/message from client to the server
### HEAD
- request headers only as if [[URL]] were requested with [[HTTP request#^d3af98]]
### PUT
- uploads new file to server
- replaces files that exists at [[URL]] with content in entity body of request

# Codes:

### Informational

### Successful
- 200 : OK
- 201 : Created
- 202 : Accepted

### Redirection
- 301 : Moved Permanently
- 304 : Not Modified
	- related to [[Web cache]]
### Client Error
- 400 : Bad Request
- 401 : Unauthorized
- 404 : Not Found
### Server Error 
- 505 : HTTP Version not Supported
- 500 : Internal server error

- [[Conditional GET]]