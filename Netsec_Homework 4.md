_by Vaughn Valle_

1. True False 802.11i provides confidentiality for the source and destination MACs (i.e., hardware addresses).
	1. False
2. True False Polymorphic malware can be detected when it executes and is decrypted with signatures based on the decrypted body of the malware present in RAM. 
	1. False
3. True False The PGP uses a web-of-trust model to provide a PKI managed by each individual user.
	1. True

# Bitcoin 

### a. Describe Bitcoin’s proof of work. Be specific about the details of the cryptographic functions used and how it adjusts to increasing or decreasing global computation ability of miners. [10 points]

## Bitcoin's Proof of Work

Bitcoin's Proof of Work (PoW) is a consensus mechanism that secures the network and verifies transactions. It operates by requiring miners to solve complex cryptographic puzzles to add new blocks to the blockchain. The core of this process lies in the SHA-256 cryptographic hash function.

SHA-256 is a one-way function that takes an input of any size and produces a fixed-size 256-bit output, often represented as a hexadecimal string. This output is deterministic, meaning the same input will always produce the same output. However, it is also computationally infeasible to reverse the process and determine the input from the output.  

In Bitcoin's PoW, miners take a block header (containing transaction data, a timestamp, and a reference to the previous block) and combine it with a nonce, a random number. This combined data is then passed through the SHA-256 function twice, producing a final hash.

The network sets a target value, which is a threshold that the resulting hash must be less than or equal to. This target is expressed in terms of difficulty, which is inversely proportional to the target. A higher difficulty means a lower target, making it harder to find a valid hash.

Miners iterate through different nonce values, repeatedly hashing the block header and nonce combination until they find a hash that meets the target. Once a valid hash is found, the miner broadcasts the block to the network, and other nodes verify the solution.

## Adjusting to Global Computational Power

The Bitcoin network is designed to adjust the difficulty every 2016 blocks (approximately every two weeks) to maintain a consistent block time of around 10 minutes. This adjustment is based on the total computational power of the network, often referred to as the hash rate.

If the hash rate increases, meaning more miners are competing to solve puzzles, the difficulty automatically increases to maintain the block time. Conversely, if the hash rate decreases, the difficulty decreases. This ensures that the network remains secure and predictable regardless of the number of miners participating.

## The Role of Difficulty in Security

The difficulty adjustment mechanism is crucial for Bitcoin's security. By requiring a significant amount of computational power to solve puzzles, PoW makes it extremely expensive and impractical for any malicious actor to attempt to manipulate the blockchain. The cost of attempting a 51% attack, where an attacker controls more than half of the network's hash rate, would be astronomical and likely outweigh any potential benefits.

b. Describe what the Bitcoin block chain achieves. [5 points]

The Bitcoin blockchain achieves several key objectives, including security, transparency, immutability, decentralization, scarcity, and trustlessness. Its decentralized nature and cryptographic hashes make tampering with transaction records extremely difficult. All transactions are publicly recorded, ensuring transparency and accountability. Once confirmed, transactions are unchangeable and irreversible, ensuring network integrity. The blockchain's decentralized control makes it resistant to censorship and manipulation. Additionally, the limited supply of Bitcoins contributes to its value and price appreciation. Finally, the blockchain operates on a trustless system, eliminating the need for intermediaries to validate transactions. Instead, it relies on cryptographic algorithms and consensus mechanisms to ensure integrity and security

# Anonymity/Privacy 
c. Describe two ways that someone can attempt to link the sender and receiver of a stream of messages sent using Tor. Be specific and describe the capabilities required by the attacker and how they would execute their attack. [5 points]

Tor, The Onion Router, is designed to provide anonymity for users by routing their internet traffic through a series of relays. This makes it difficult to trace the origin or destination of a message. However, there are still ways that an attacker can attempt to link the sender and receiver of a stream of messages sent using Tor. This document will describe two such methods.

## Traffic Analysis

- **Attacker Capabilities:** The attacker needs to be able to observe traffic entering and exiting the Tor network at multiple points. This could involve compromising Tor relays or monitoring internet traffic at internet service providers (ISPs) or other network choke points.
- **Attack Execution:** The attacker observes the timing and volume of traffic entering the Tor network from the suspected sender and the timing and volume of traffic exiting the Tor network to the suspected receiver. By correlating these patterns, the attacker may be able to infer that the two are communicating. For example, if the attacker sees a burst of traffic entering the network from the sender followed shortly by a burst of traffic exiting the network to the receiver, this could suggest a link.

## Website Fingerprinting

- **Attacker Capabilities:** The attacker needs to be able to modify the content of websites visited by the target user. This could involve compromising the website itself or using a man-in-the-middle attack to inject content into the website's traffic.
- **Execution:** The attacker modifies the website in a unique way for each user, such as by adding a hidden image or changing the spacing of elements on the page. When the user visits the website using Tor, the attacker can observe the unique modifications in the traffic exiting the Tor network. This can allow the attacker to fingerprint the user and potentially link them to their real IP address. If the attacker observes the same fingerprint in traffic exiting the Tor network to the suspected receiver, this could suggest a link.

d. Describe the concept of anonymity and how it differs from message confidentiality. [5 points]
Anonymity refers to hiding or protecting the identity of the sender, recipient, or both in a communication process. It ensures that the individuals involved in the communication cannot be easily identified or traced.

Message confidentiality, on the other hand, ensures that the content of a communication remains private and cannot be accessed by unauthorized parties. The identity of the sender and receiver may be known (no anonymity), but the message content is encrypted or secured.

# Research Paper and Questions
Research Paper and Questions (10 points) Produce a one-page summary of one of the papers below. In your summary included the novel contributions of the paper beyond prior work, the practical implications of their findings, and a concise summary of the methods of how they conducted their exploration of the problem.

# SoK: Secure Messaging

Motivated by recent revelations of widespread state surveillance of personal communication, the authors of "SoK: Secure Messaging" evaluate and systematize current secure messaging solutions, proposing an evaluation framework for their security, usability, and ease-of-adoption properties. The paper considers solutions from both academia and "in-the-wild" projects, identifying three key challenges and mapping the design landscape for each: trust establishment, conversation security, and transport privacy.

## Novel Contributions

The paper makes several novel contributions beyond prior work in the field of secure messaging. These include:
- Establishing a set of common security and privacy feature definitions for secure messaging.
- Systematizing secure messaging approaches based on academic work and "in-the-wild" projects.
- Conducting a comparative evaluation of these approaches, highlighting their strengths and weaknesses.
- Identifying and discussing current research challenges, thereby indicating future research directions.

## Practical Implications

The findings of the paper have several practical implications for the development and adoption of secure messaging solutions. For example, the paper highlights the trade-offs between security, usability, and ease of adoption, emphasizing the need for solutions that balance these factors effectively. The paper also underscores the importance of addressing key challenges such as trust establishment, conversation security, and transport privacy in order to achieve widespread adoption of secure messaging:

### Systemization Methodology
- **Problem Areas:** The trust establishment problem, the conversation security problem, and the transport privacy problem.
- **Threat Model:** Includes local and global adversaries, service providers, and the assumption that endpoints are secure.
- **Systematization Structure:** Identifies desirable properties for each problem area, extracts generic approaches, and evaluates them in terms of security, usability, and adoption.
### Trust Establishment
- **Key Challenges:** Balancing strong security with usability and adoption.
- **Approaches:** Opportunistic encryption, Trust-On-First-Use (TOFU), key fingerprint verification, short authentication strings (SAS), secret-based zero-knowledge verification, mandatory verification, authority-based trust, transparency logs, blockchains, and others.
- **Findings:** No single approach is perfect; trade-offs exist between security, usability, and adoption.
- **Promising Directions:** Layered designs combining central key directories with additional verification options and TOFU warnings.
### Conversation Security
- Key Challenges: Automating security without compromising user experience, supporting multiple devices, and ensuring resilience in asynchronous environments.
- Approaches: Trusted central servers, static asymmetric cryptography, forward secure identity-based encryption (FS-IBE), authenticated Diffie-Hellman, key evolution, Diffie-Hellman ratchet, double ratchet, and others.
- Findings: Most widely adopted solutions have the weakest security. Asynchronous communication with forward and backward secrecy is a challenge.
- Promising Directions: Combining the double ratchet with a 3-DH handshake and prekeys (e.g., TextSecure).
### Transport Privacy
- Key Challenges: Providing strong anonymity against global adversaries while remaining practical.
- Approaches: Store-and-forward, onion routing, DC-nets, broadcast systems, and private information retrieval (PIR).
- Findings: Achieving strong privacy against global adversaries often comes with significant usability and adoption costs.
- Open Questions: Balancing privacy, usability, and scalability remains a challenge.
## Methodology

The authors employ a systematic approach to evaluate secure messaging solutions. They begin by defining problem areas and establishing a threat model. They then identify desirable properties for each problem area, including security and privacy features, usability features, and adoption considerations. The authors extract generic approaches used to address each problem area from existing secure messaging systems and evaluate these approaches in terms of the defined properties. Finally, they discuss the implications of their findings and suggest future research directions.

## Conclusion

In conclusion, "SoK: Secure Messaging" provides a comprehensive overview of the current state of secure messaging. The paper's novel contributions, practical implications, and systematic methodology make it a valuable resource for researchers, developers, and users interested in secure communication.
