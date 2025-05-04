_made in Obsidian.mc_


### Slide 9
First, since I was on my own personal Arch build, I had to download the default `nmap.lst` from a repo
```bash
sudo pacman -Sy wget
wget https://raw.githubusercontent.com/drtychai/wordlists/refs/heads/master/nmap.lst
```
I then added my own `l33tsp34k` custom rule for JohnTheRipper
```ini
[List.Rules:l33tsp34k]
sa@       
sA@      
sb8      
sB8      
sc(      
sC(      
se3      
sE3      
sg6      
sG6      
si1      
sI1      
sl1      
sL1      
so0      
sO0      
sq9      
sQ9      
ss5      
sS5      
st7      
sT7      
sz2      
sZ2      
sx%
```
I used the following command to convert the dict entries to l33tsp34k :)
```bash
john --wordlist:./lab9.lst --rules:l33tsp34k --stdout
```
![[Pasted image 20250504023601.png]]
Complete output here:
```txt
P@ssword
Princess
P@ssword1
Michelle
D@nielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Prin(ess
Password1
Mi(helle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princ3ss
Password1
Mich3ll3
Dani3ll3
J3nnif3r
Liv3rpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Pr1ncess
Password1
M1chelle
Dan1elle
Jenn1fer
L1verpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Miche11e
Danie11e
Jennifer
Liverpoo1
Password
Princess
Password1
Michelle
Danielle
Jennifer
1iverpool
Passw0rd
Princess
Passw0rd1
Michelle
Danielle
Jennifer
Liverp00l
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Pa55word
Prince55
Pa55word1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
Password
Princess
Password1
Michelle
Danielle
Jennifer
Liverpool
```


### Slide 31
First I installed the `nvidia` and `cuda` drivers I needed to run hashcat on my NVIDIA GPU on Arch
```bash
sudo pacman -Sy nvidia cuda
```
then I generated the hashes with
```bash
hashcat -a 6 -m 1800 hashes.lst nmap_short.lst  -o hashes.out
```
then cracked the password with
```bash
john --wordlist:./dict.lst ./hashes.lst –-format=crypt
```
![[Pasted image 20250504025433.png]]
Answer: `$ofTBa11!999`
### Slide 52
![[Pasted image 20250504024618.png]]