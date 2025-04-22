---
tags:
  - netsec
---
_by Vaughn Valle_

### Q1.1 Snort

Snort is an open-source, rule-based Network IDS/IPS

## What is an IDS?
- IDS is a passive monitoring solution for detecting malicious activities
- If a signature is identified, an alert is created
	- Types
		- [[NIDS]]
			- monitor traffic flow on entire subnet
		- [[HIDS]]
			- monitor traffic flow from single endpoint
## What is an IPS?
- IPS is an active protecting solution to terminate an event as soon as detection is performed
- If a signature is identified, the conn is terminated

Types:
	- [[NIPS]]
		- protect traffic on entire subnet
	- [[NBA]]
		- similar to [[NIPS]] but requires a training period (baselining) to differentiate normal vs malicious, more efficient results
	- [[WIPS]]
		- protect wireless traffic
	- [[HIPS]]
		- protect traffic on an endpoint

## Detection/Prevention Techniques
1. Signature-based
	1. identify specific patterns of known malicious behavior
2. Behaviour-based
	1. identify new threat with new patterns that pass signatures
3. Policy-based
	1. identify activities by comparing them with config and sys policies

Snort can be a packet sniffer, packet logger, or a full-blown [[NIPS]]
![[Pasted image 20241112224940.png]]

## Snort Rule structure
![[Pasted image 20241124181839.png]]
[Snort Usage]()
### Q1.2 Snort Challenges
![[Pasted image 20241124201633.png]]

This lab was very fun as it doubled down on using snort to analyze real world traffic. At the end, I was able to use snort to analyze `pcap` files to investigate real world exploits and vulnerabilities

### Q3 ZeekBro

## Zeek
Zeek is a passive open-source traffic analyzer and is mainly used as a network security monitor (NSM)
## Zeek vs Snort

![[Pasted image 20241124225515.png]]
### Q3.2 Zeekbro Exercises
![[Pasted image 20241127175120.png]]
### Q4 Splunk

### Q4.1 Splunk Dashboard and Reports

### Q4.2 Splunk Data Manipulation

### Q5 Lab Write-up