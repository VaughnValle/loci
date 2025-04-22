---
tags:
  - offsec
---
_by Vaughn Valle_

Finally, this week is more chill with web CTF challenges.

## Validator
Site: `http://offsec-chalbroker.osiris.cyber.nyu.edu:1502/index.php`
The site greets us with a t-shirt selling home page. If we navigate to contacts page, we can see a Name, Email, and file form that allows us to upload a file.
![[Pasted image 20241126174552.png]]

##  Ping
Site: `http://offsec-chalbroker.osiris.cyber.nyu.edu:1503`

When accessing the site, we get greeted by a simple Ping page with an input box
![[Pasted image 20241126172652.png]]
Using Burp suite, let's try to input `1.1.1.1`.
![[Pasted image 20241126172736.png]]
Seems like a regular ping command. Here's the following POST request
```http
POST /ping.php HTTP/1.1
Host: offsec-chalbroker.osiris.cyber.nyu.edu:1503
Content-Length: 10
Accept-Language: en-US,en;q=0.9
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36
Content-Type: application/x-www-form-urlencoded
Accept: */*
Origin: http://offsec-chalbroker.osiris.cyber.nyu.edu:1503
Referer: http://offsec-chalbroker.osiris.cyber.nyu.edu:1503/?
Accept-Encoding: gzip, deflate, br
Cookie: CHALBROKER_USER_ID=vqv9731
Connection: keep-alive

ip=1.1.1.1
```
And here is the server response
```http
HTTP/1.1 200 OK
Date: Tue, 26 Nov 2024 22:27:11 GMT
Server: Apache/2.4.54 (Debian)
X-Powered-By: PHP/7.4.33
Vary: Accept-Encoding
Content-Length: 242
Keep-Alive: timeout=5, max=100
Connection: Keep-Alive
Content-Type: text/html; charset=UTF-8

PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=54 time=1.98 ms

--- 1.1.1.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.975/1.975/1.975/0.000 ms
```
Let's try to inspect the web page
![[Pasted image 20241126173102.png]]

Here we see that our input goes into `ip`, which does no input sanitization enclosed in the `<script></script>` tags

Since it expects a ping command, a `;` will make the server execute nothing and escape. Anything we append afterward will be executed as another command.
![[Pasted image 20241126173259.png]]
Here we can see a suspicious file called `f14g_cmdi.php`. We can navigate to this php file by modifying the URL and get the flag

Flag at  `http://offsec-chalbroker.osiris.cyber.nyu.edu:1503/f14g_cmdi.php`
## LFI
Site: `http://offsec-chalbroker.osiris.cyber.nyu.edu:1500`
Navigating to the site we get this
![[Pasted image 20241126175557.png]]
simpel LFI file path inclusion doesn't working e.g. attaching `page=../../flag.txt` 
![[Pasted image 20241126175705.png]]
There seems to be a `flag.php` in the dir via `page=flag`
![[Pasted image 20241126175934.png]]
However, using the php filter command in the notebook to get the flag with php `resource` gives us 
![[Pasted image 20241126175817.png]]
This looks like a bas64 string. Decoding it gives us the flag.
![[Pasted image 20241126175903.png]]