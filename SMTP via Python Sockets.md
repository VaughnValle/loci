---
tags:
  - "#comp-net"
---
### Why did Cloudflare mail server fail?
1. Strict [[SPF]] Policy ^423ff8
2. Message headers missing [[DKIM]] signature ^2128fc
3. [[DMARC]] did not pass since [[SMTP via Python Sockets#^423ff8]] and [[SMTP via Python Sockets#^2128fc]] did not pass