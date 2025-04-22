---
tags:
  - netsec
---
_by Vaughn Valle_

## Burp Suite: Basics
![[Pasted image 20241219184939.png]]
## Burp Suite: Repeater
![[Pasted image 20241219212703.png]]

## Burp Suite: Intruder
![[Pasted image 20241219214955.png]]

## Writeup 

This writeup summarizes my experiences and insights from completing several web security labs, including those focused on Burp Suite’s features and TryHackMe rooms on OWASP, SQL injection, and encryption. These exercises enhanced my understanding of web vulnerabilities, exploitation techniques, and mitigation strategies.
### Burp Suite: The Basics (20 Points)
I began by familiarizing myself with Burp Suite's interface, exploring tools like the Proxy, Target, and Dashboard. The lab provided a hands-on environment to intercept HTTP/S traffic, manipulate requests, and understand the workflow of web applications.

**What I Learned:**
- **Traffic Interception:** Gained the ability to intercept and modify HTTP requests/responses in real-time.
- **Web Application Workflow:** Observed how data is sent between clients and servers, identifying potential entry points for attacks.
- **Basic Analysis:** Learned to analyze headers, cookies, and parameters for vulnerabilities.
    
### Burp Suite: Repeater (30 Points)

 Using the Repeater tool, I manually crafted and sent HTTP requests to a target server to analyze responses. This lab emphasized repetitive testing of endpoints with customized input.

**What I Learned:**
- **Manual Testing:** Understood the importance of precision in sending crafted payloads to specific endpoints.
- **Response Analysis:** Learned to interpret server responses to identify vulnerabilities like authentication flaws and parameter tampering.
- **Enhanced Debugging:** Repeater’s iterative approach provided clarity in understanding application behavior under various inputs.

### Burp Suite: Intruder (20 Points)

 The Intruder tool was used to automate sending a large number of payloads to test for vulnerabilities such as brute force attacks, injection points, and enumeration. I configured positions, added payload sets, and analyzed results.

**What I Learned:**
- **Automation in Security Testing:** Realized the efficiency of automated payload testing for discovering weak points in web applications.
- **Payload Customization:** Explored creating specific payloads tailored to target vulnerabilities.
- **Rate Limiting and Security Mechanisms:** Identified how applications implement countermeasures against automated attacks.

### TryHackMe: OWASP Top 10 2021 (30 Points)

 This room covered the OWASP Top 10 web vulnerabilities, including practical exploitation of issues like XSS, SQL Injection, and Insecure Direct Object References. I completed challenges that simulated real-world scenarios.

**What I Learned:**
- **Awareness of Common Vulnerabilities:** Gained deeper insights into risks like Broken Access Control, Security Misconfigurations, and Sensitive Data Exposure.
- **Exploitation Techniques:** Practiced attacking vulnerable applications to understand how malicious actors exploit weaknesses.
- **Defensive Strategies:** Learned about remediation measures such as input validation, proper authentication mechanisms, and secure configurations.

### TryHackMe: SQL Injection (Extra Credit - 10 Points)

 The lab focused on identifying and exploiting SQL injection vulnerabilities. I practiced finding injectable fields, crafting SQL payloads, and extracting sensitive data.

**What I Learned:**
- **Injection Basics:** Understood how unsanitized inputs can lead to database exploitation.
- **Advanced Payloads:** Learned to bypass authentication and retrieve database structures.
- **Mitigation Strategies:** Explored methods like parameterized queries and input validation.

### TryHackMe: Encryption Crypto 101 (Extra Credit - 20 Points)

 This room introduced fundamental cryptographic concepts, including symmetric and asymmetric encryption, hashing, and encoding. I solved challenges involving encryption keys, cipher decoding, and hash cracking.

**What I Learned:**
- **Cryptographic Techniques:** Developed a strong understanding of encryption algorithms and their real-world applications.
- **Weaknesses in Cryptography:** Identified issues like poor key management and outdated algorithms that weaken encryption.
- **Secure Practices:** Learned best practices for implementing and managing cryptographic systems.

### Conclusion

These labs collectively enhanced my technical expertise in web security. Burp Suite tools provided a robust framework for identifying and exploiting vulnerabilities, while the TryHackMe rooms offered comprehensive insights into real-world scenarios and advanced concepts. This experience solidified my understanding of securing web applications against common threats and fostering a proactive security mindset.

# Extra Credits
## OWASP Top 10
![[Pasted image 20241219231617.png]]

## Burp Suite: SQL Injection
![[Pasted image 20241219220617.png]]
## Burp Suite: Encryption - Crypto 101
![[Pasted image 20241219221819.png]]
