---
tags:
  - netsec
---
_by Vaughn Valle_

1. Generating and appending an HMAC to a message provides message confidentiality. 
	- False
2. Storing unsalted MD5 hashes of passwords will protect the password if the hashes leak.
	- False
3. TCP sequence numbers mitigate spoofing attacks from off-path attackers who cannot eavesdrop.
	- True
4. Disabling auto-trunking mitigates VLAN hopping attacks.
	- Assuming by auto-trunking you mean DTP, then:
	- True
6. A sufficiently large key size is necessary but not sufficient for a symmetric encryption algorithm to be computationally infeasible for an attacker to decrypt the cyphertext.
	- True
### Authentication

> Your NYU ID card contains many different factors which may be used for identification, authentication, or authorization. Describe three scenarios in which your NYU ID card is used for each of these. For each scenario, answering the following: (6 points undergrads) (4 points grads) for each scenario.

#### Scenario 1: Entering NYU buildings
This scenario describes the process of tapping your NYU ID Card in reception desks to gain entry to buildings/floors
- This scenario involves authentication and authorization
- A physical factor is involved which is the NYU ID Card
- The system is very secure since the security guard is cross referencing the details on the card Card with the information they have on their database and if the person physically present matches the profile that pops up on the security guard's screen.
- It would be really bad if the system were compromised since it would allow unauthorized people and threats to enter campus buildings putting students', faculty, and staff's lives at risk.
- The likelihood of such attack to occur would depend on the building involved. At Tandon, I believe the likelihood is low unless an important person were inside.
- I believe the current security system is sufficient. The baseline strictness is high for all buildings, and only gets higher in certain protected floors.

#### Scenario 2: Accessing online NYU Services
This scenario describes the process of entering your NetID and password on shibboleth enabled NYU online sites to access NYU restricted content and resources
- This scenario involves authentication and authorization
- The factors involved would be the NetID and password
- The system is secure because NYU deploys 2 factor authentication with Duo mobile 
- If the system were compromised, the damage could be catastrophic since student data and information is at risk. If an attacker gains unauthorized access to a privileged NYU Account, they have control over all digital aspects of that student account (organizational, financial, and coursework related data)
- I think 2 Factor Authentication with Duo Mobile is sufficient. The cost in increasing security with more hardware based authentication would be too much since an attacker would have to get physical access to the owner's phone anyway.

#### Scenario 3: Getting delicious halal food from the Halal boss by Marriott
This scenario describes me showing the Halal guy by Marriott my NYU ID card to get a free soda with my halal food purchase
- This scenario involves identification
- The factors involved is the photo on my ID and the physical NYU ID Card
- The system is not secure since anyone can forge a student/NYU Card and claim that they are a student to get a free soda from the HALAL BOSS
- If the system was compromised, the HALAL BOSS would gain less profit because of people pretending to be students and unrightfully getting free sodas
- I think this method of security is not sufficient. The HALAL BOSS can resolve this by further verifying student status like showing their course load or schedule. 


### Attacks

> a. Describe one attack that confidentiality mitigates and one attack that authenticity mitigates?

Confidentiality is one of the three main pillars of information security (along with integrity and availability). It ensures that data is kept secret from unauthorized users. For confidentiality, the attack I'm going to be looking into is a typical _eavesdropping attack_.

In an eavesdropping attack:
1. An attacker secretly listens to private communications (mainly through some sort of spoofing).
2. This can occur over network traffic, phone lines, or even through physical means like hidden microphones.
3. The goal is to gain access to sensitive information like passwords, financial data, or trade secrets across an insecure network.

Eavesdropping in a Starbucks cafe for example can be easily mitigated through confidentiality:
1. **Encryption:** Transforming data transmitted within applications into a format unreadable without the proper decryption key.
2. **Secure protocols:** Using HTTPS instead of HTTP for web traffic
3. **VPNs:** Creating encrypted tunnels for data transmission.

Authenticity ensures that the origin of a message or document is genuine and verifiable. For this, I'm going to be looking into _man-in-the-middle attacks_

In a man-in-the-middle (MITM) attack:
1. An attacker intercepts communications between two parties (ARP poisoning for one).
2. They can eavesdrop, but also potentially modify or inject new messages.
3. Both original parties believe they're communicating directly with each other.

Mitigation through authenticity:
1. Digital signatures: Cryptographic technique to verify the sender's identity and message integrity such as DKIM, SPF, and DMARC, all of which can be easily integrated via Cloudlare
2. Public Key Infrastructure (PKI): System of digital certificates, certificate authorities, and other tools to manage public-key encryption.
3. Message Authentication Codes (MACs): Ensuring message integrity and authenticity using a shared secret key.
4. Multi-factor authentication: Requiring additional proof of identity beyond just a password.


> b. Describe a cryptographic method for achieving authentication and one for achieving confidentiality.

For authentication, digital signatures use public key cryptography to verify the authenticity and integrity of messages or documents, as discussed in [[Netsec HW2#Attacks]] such as DSA, HMAC, and DKIM+SPF+DMARC for email authenticity. The sender uses their private key to encrypt a hash of the message, creating the signature. Recipients can then verify the signature using the sender's public key, confirming the message came from the purported sender and wasn't altered.

For confidentiality, symmetric encryption uses a shared secret key to both encrypt and decrypt messages. Common algorithms like AES transform plaintext into ciphertext that appears random to anyone without the key. Only parties with the secret key can decrypt and read the original message, keeping its contents confidential.