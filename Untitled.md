- What
	- The "Channel File 291" incident
	- A global outage resulting in millions of Windows systems failing from the infamous [[BSOD]]
	- Total damage to Fortune 500 companies: $5.4 billion
- How
	- CrowdStrike Falcon is a Security as a Service (SAAS) platform
		- Crowdstrike is an endpoint security vendor whose core technology is Falcon
		- Falcon is an advanced cloud-exclusive malware research tool enabling companies to minimize threats and cybersecurity risks
	- CrowdStrike Falcon is deeply integrated in many mission-critical operations and industries globally
		- And this was how a fault in this essential service led to catastrophic failures globally
	- User-level processes operate within a sandboxed environment in the OS
		- When an error occurs, the process can be immediately isolated 
	- Falcon attaches itself to the host's Windows Operating System as a [kernel] level process
		- This means that Falcon has extremely escalated privileges, having direct access and control over a system's hardware and software	
			- kernel-level processes perform actions without restrictions
		- Because of this a simple logic error can immediately crash the operating system and render the host machine unusable
		- And this is exactly what happened!
		- There was a logic flaw in Falcon sensor version 7.11 and above, causing it to crash
- When
	- On July 19, 2024
		- 12 AM - Crowdstrike released a sensor configuration update to Windows systems aimed to provide users with bleeding edge mitigation and threat protection
			- The update was packaged in a file that CrowdStrike refers to as "channel files," which specifically provide configuration updates for behavioral protections. 
			- This update was labeled "Channel file 291", an update that was supposed to help improve how Falcon evaluates named pipe execution on Microsoft Windows. Named pipes are a common type of communication mechanism for inter-process communications on Microsoft Windows.
		- In between 12AM and 1:27 AM
			- Systems running Falcon sensor for Windows 7.11 and above began to crash
			- With channel file 291, CrowdStrike inadvertently introduced a logic error, causing the Falcon sensor to crash and, subsequently, Windows systems in which it was integrated. 
			- The flaw isn't in all versions of channel file 291. The problematic version is channel file 291 (C-00000291*.sys) with timestamp 2024-07-19 0409 UTC. 
			- CrowdStrike acknowledges issue and reverted the faulty update
				- Corrected Channel 291 file was deployed
		- 1:27 AM
			- Channel file 291 timestamped 2024-07-19 0527 UTC or later does not have the logic flaw. By this time, CrowdStrike had noticed its error and reverted the change. But, for many of its users, that reversion came too late as they had already updated, leading to BSOD and inoperable systems globally.
	- On July 20, 2024
		- CrowdStrike updated remediation hub and clarified that it was not a cyber attack
	- On July 21, 2024
		- Microsoft released the Preinstallation Environment Recovery tool to find and remove the faulty update
- Where
	- What was affected?
		- 8.5 million Windows machines
			- Airlines and airports
				- Thousands of flights were grounded in airports globally
				- Resulting in delays and cancellations of over 10k flights
			- Public transits systems even here in NYC crashed
				- Subway screens displaying train info suffered from the same issue
			- Healthcare appointment systems
				- 911 emergency services
			- Online banking systems
				- Payment platforms
			- Sky News were taken off the air because of the outage
		- $5.4 billion in financial damage
	- 