---
tags:
  - osiris
---
## Overview 
- What we will be doing
- Why should I care about androids
	- 2023, Android has 70.29% market share globally
	- Android is usually more affordable
- Why is it important to talk about android hacking
	- 3 main threats
		- Data Interception
		- Malicious Apps
			- Which is what we'll be doing today
			- By understanding the process of how it's done (although in a simpler way), we can better protect ourselves and the people around us 
		- SMS Phishing

---

## APKs?
- What are they
	- Android Package Kit
- Why are they important
- Why are they a commonly used for exploits

## Android Debug Bridge
- Facilitates communication with device 
- Your gateway to Android's inner workings
## The Metasploit Framework
- What it is
	- Exploits
	- Payloads
	- Auxiliaries
	- Encoders
- Walkthrough
	- msfconsole
	- msfdb
	- msfvenom
	- meterpreter

## Reverse Shell
## Steps
- injecting malicious reverse shell onto existing app
- installing app
- listening for reverse shell
- do whatever we want!
## Limitations
- Ridiculous social engineering 
- Machine is already exploitable
	- Dev Ops & USB Debugging
## Tools
- Android Debug Bridge (ADB)
- Metasploit Framework
- Phonesploit Pro 
## Demo
- Replicate Metasploit via ADB
1. Install and setup ADB
2. Setup ADB Wireless
3. Install and spinup Phonesploit pro
4. Setup Metaploit and install reverse_shell
5. Experiment