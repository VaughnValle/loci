---
tags:
  - netsec
---
# "Channel File 291": The 2024 CrowdStrike Incident
_by Vaughn Valle_

### Event Article 

On July 19, 2024, in a shocking turn of events, 8.5 million Windows machines all around the world crashed with the infamous "Blue Screen of Death" or BSOD. Airlines were forced to ground flights, public transit systems were disrupted, and emergency services were compromised. 

> Airports suffered significant disruptions with thousands of flights grounded globally. Public transit systems in cities like NYC experienced outages in displaying train arrival times. Healthcare appointment systems in hospitals and 911 services were unoperational. Online banking systems worldwide were offline leaving billions of people unable to use payment services.

It sounds like a dystopian reality you would only see in a Black Mirror episode on Netflix. After all, no one thought the world stood on a fragile digital pillar that could break at any moment. But this catastrophe serves as a stark reminder of the centralized and vulnerable nature of the modern digital world.

At the heart of this incident was CrowdStrike Falcon, a widely-used security as a service (SaaS) platform and CrowdStrike's—a leading endpoint security vendor—core technology. CrowdStrike Falcon is deeply integrated in many mission-critical operations and industries globally and attaches itself to the host's Windows Operating System as a kernel-level process. While user-level process operate within a sandbox environment within the OS, kernel-level process have direct access to the OS. This means that Falcon has extremely escalated privileges, having direct access and control over a system's memory, network cards, storage drive, and I/O devices. Because of this, a simple logic error can immediately crash the operating system and render the host machine unusable. This was exactly what happened.

> CrowdStrike, a leading endpoint security vendor, had just released a faulty sensor configuration update intended to enhance its Falcon platform.

At 12 A.M., on the 19th of July, Crowdstrike released a sensor configuration update to Windows systems aimed to provide users with bleeding edge mitigation and threat protection. The update was packaged in a file that CrowdStrike refers to as "channel files," which specifically provide configuration updates for behavioral protections. This specific update, labeled "Channel file 291", was intended to enhance its Falcon platform's evaluation of named pipe execution on Windows systems, further upgrading the service's endpoint protection capabilities. However, a critical logic error caused the Falcon sensor to crash, bringing along the Windows operating system with it. While designed to protect systems from cyber threats, this mishap led to a cascading effect that brought down critical infrastructure across various sectors. The impact was immediate and far-reaching.
 
> The update inadvertently introduced a logic flaw that caused the Falcon sensor to crash, rendering millions of affected Windows systems inoperable.

Upon realizing the issue, CrowdStrike swiftly acknowledged the problem and reverted the faulty update. A corrected version of channel file 291 was deployed, with a timestamp of `2024-07-19 0527 UTC`. Unfortunately, for many CrowdStrike-integrated systems, the reversion came too late. Systems had already updated to the faulty version and were fatally crashing, leading to widespread Blue Screen of Death (BSOD) errors and inoperable systems globally. 

In the days following the incident, CrowdStrike updated its remediation hub to clarify that the issue was not a cyber attack and provided guidance for affected users. On July 21, 2024, Microsoft also stepped in to assist, releasing the Preinstallation Environment Recovery tool: a tool designed to help users identify and remove the faulty update from their systems.

> CrowdStrike made it clear that the outage was not a cyber attack. Microsoft assisted by providing a Windows tool to help with removing the faulty CrowdStrike update

This technological disaster highlights the critical importance of quality and testing in software updates, particularly those from cybersecurity providers with services offered globally. While CrowdStrike acted swiftly to address the issue, the widespread impact of the faulty update emphasizes the potential global consequences of such errors. The financial toll of the incident is estimated to be $5.4 billion, underscoring the significant economic consequences of such a widespread cybersecurity outage (Fortune, 2024). 

It is true that incidents to this extent are rare, but they give importance to rigorous testing and quality assurance (QA) involved in software development, particularly for critical security solutions.

### Security Review

#### Rethinking the way we handle Computer Security

Considering the extent of the outage, and the personal impact it had towards my personal life and family most especially from airline delays, I'd like to take this opportunity of writing the security review as a means to analyze the technology Falcon uses and devise ways it can be improved to prevent such catastrophes from occurring again.

It is absurd to think that despite the extent of the damage caused by the "Channel 291" outage, it was never a cyber attack—just a mere logic error. A logic error caused a global catastrophe simply because it occurred at the kernel level: with direct access to the operating system.

The approach being evaluated is the concept of limiting kernel-level access in operating systems to remove the need of endpoint protection and response (EDR) systems being a kernel-level process.. This approach aims to reduce the risk of EDR causing outages or being compromised by adversaries, as they would have less direct control over the operating system's core functionalities. 

Apple's implementation of this concept in its macOS operating system demonstrates its feasibility and potential benefits. By limiting kernel-level access, EDR systems do not need to be monitoring and mitigating security threats at the kernel/operating system level.

#### Assets and Security Goals

The primary asset is the data stored on and processed by the endpoint device. The security goal is to protect this data from unauthorized access, modification, or deletion. This is crucial as endpoint data often contains sensitive information such as personal details, financial records, and intellectual property.

The integrity of the endpoint device itself is another critical asset. The security goal is to ensure that the device remains free from malware, unauthorized modifications, and other compromises. This is important as a compromised endpoint can serve as a gateway for attackers to access and exploit other systems within a network.

##### Potential Threats

A common threat is the infection of the endpoint with malicious software such as viruses, worms, or ransomware. Adversaries can use various techniques to deliver malware, including phishing emails, malicious websites, and exploit kits. Another threat involves attackers gaining elevated privileges on the endpoint, allowing them to execute commands with higher authority/privileges. This can be achieved through vulnerabilities in the operating system or applications, or by exploiting weak authentication mechanisms rendering EDR systems useless.

#### Potential Weaknesses

Despite the limitations on kernel-level access, EDR systems themselves can still be vulnerable to attacks. Bugs in the EDR software or configuration errors could create opportunities for systems to crash and adversaries to exploit. Adversaries may target the supply chain of EDR vendors to introduce malicious code or backdoors into the software. This could compromise the security of endpoints that use the affected EDR system.

#### Potential Defenses

Keeping the operating system and EDR software up-to-date with the latest security patches can help mitigate vulnerabilities and address known threats. Isolating endpoints from other systems within the network can limit the potential damage if an endpoint becomes compromised. Training users to be aware of common threats and best practices for online security can help prevent them from falling victim to phishing attacks and other social engineering tactics.

The concept of limiting kernel-level access for endpoint protection systems offers a promising approach to enhancing endpoint security. By reducing the attack surface, it can make it more difficult for adversaries to compromise endpoints and exploit sensitive data. However, it is important to recognize that this is not a silver bullet solution. A comprehensive security strategy that includes regular updates, network segmentation, and user education is still essential to protect endpoints from various threats.

As technology continues to evolve, it is likely that new threats and vulnerabilities will emerge. It is crucial to stay informed about the latest security trends and adapt security measures accordingly. Additionally, ethical considerations should be taken into account when implementing security measures, ensuring that they do not unduly restrict legitimate activities or infringe on privacy rights. However, in the context of the Crowdstrike incident, Linux and macOS were unaffected because of the way both handle kernel access, which led to the channel 291 file never being issued to macOS or Linux systems.

References:
- [TechTarget Explained](https://www.techtarget.com/whatis/feature/Explaining-the-largest-IT-outage-in-history-and-whats-next)
- [NY Times: Stranded in the CrowdStrike Meltdown](https://www.nytimes.com/2024/09/13/travel/crowdstrike-outage-delta-airlines.html)
- CrowdStrike Resources
	- [Executive Summary](https://www.crowdstrike.com/blog/channel-file-291-rca-available/)
	- [Root Cause Analysis (RCA)](https://www.crowdstrike.com/falcon-content-update-remediation-and-guidance-hub/)
-  [Dell: What is the CrowdStrike Falcon Platform](https://www.dell.com/support/kbdoc/en-us/000126839/what-is-crowdstrike)
- [Fortune](https://fortune.com/2024/08/03/crowdstrike-outage-fortune-500-companies-5-4-billion-damages-uninsured-losses/)
- [CrowdStrike Falcon Areas of Improvement](https://www.peerspot.com/questions/what-needs-improvement-with-crowdstrike-falcon)