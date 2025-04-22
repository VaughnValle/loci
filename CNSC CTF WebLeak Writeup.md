
_by Vaughn Valle and Vivek Radhakrishnan_

This challenge gives us a flask website and an admin bot. Upon opening the site we are greeted with a forum
![[Pasted image 20241220234621.png]]
The site gives us a hint to leak the admin token. This site is likely vulnerable via XSS. If we can get javascript to run on this page, we can steal the cookie through giving a XSS URL to admin bot
### Source Code

Since we are given the source code via ZIP, these code snippets piqued my interest
```python
from flask import Flask, request, render_template, g, Response, send_file
import sqlite3
from os import environ, path
from random import randbytes, randint
import re

app = Flask(__name__)

con = sqlite3.connect("posts.db", check_same_thread=False)
cursor = con.cursor()
cursor.executescript(f"""
CREATE TABLE posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,  -- Unique identifier for each post
    author TEXT NOT NULL,             -- Name of the author
    content TEXT NOT NULL                -- Content of the blog post
);
                  
INSERT INTO posts (author, content) VALUES ("user", "Today is a very nice day");
INSERT INTO posts (author, content) VALUES ("user", "I wonder how many challenge can I solve today");
INSERT INTO posts (author, content) VALUES ("user", "Maybe I should go touch some grass?");
INSERT INTO posts (author, content) VALUES ("user", "I'm gonna fill all the posts with non-sense texts");
INSERT INTO posts (author, content) VALUES ("user", "Can I leak the admin's note?");
INSERT INTO posts (author, content) VALUES ("admin", "{environ['FLAG'] if 'FLAG' in environ else 'W1{flag}'}");
""")

SECRET_TOKEN = environ["SECRET_TOKEN"] if "SECRET_TOKEN" in environ else randbytes(16).hex()
AUTHENTICATION_TOKEN = "".join([str(randint(0, 9)) for _ in range(64)])
print("DEBUG:", SECRET_TOKEN)
print("DEBUG:", AUTHENTICATION_TOKEN)

CSP = "default-src 'none'; style-src 'unsafe-inline'; img-src 'self'; script-src 'nonce-%s'"
```
There exists two tokens, also a CSS CSP vuln with `unsafe-inline`
```python
@app.route("/search")
def do_search():
    res = Response()
    res.headers['Content-Security-Policy'] = g.csp
    res.response = render_template("error.html")

    if auth(request.args.get('token', request.args.getlist('token[]'))):
        try:
            keyword = request.args.get('k', "")
            cursor = con.cursor()
            is_admin = False
            if request.cookies.get("SECRET_TOKEN"):
                if request.cookies.get("SECRET_TOKEN") == SECRET_TOKEN:
                    is_admin = True

            posts = cursor.execute("SELECT author, content FROM posts WHERE content like ?", (keyword.replace("%", "").replace("?", "") + "%",)).fetchall()
            
            res.response = render_template("list.html", posts=posts, is_admin=is_admin, nonce=g.nonce)
        except:
            pass
    return res

```
Basically, if we can get access to the right `SECRET_TOKEN` we can set ourselves as admin and print out the flag. Here we see that the route `/search` is a vulnerable endpoint and that we can use 
```
http://127.0.0.1:1337/search?token=7934976433146439999636864483132251485613945348629731889451869588k={XSS}
```

 to get the flag. We just need to give this to the admin bot site and monitor via webhook
### Webhook
![[Pasted image 20241220234439.png]]

### Flag
Once we get both `SECRET_TOKEN` and `AUTHENTICATIN_TOKEN`, we get the flag
![[Pasted image 20241220235306.png]]