---
tags: offsec
---
_by Vaughn Valle_

## SSL
The random seed is generated using `time(nullptr)`, which provides very low entropy. The seeding method uses `rax_1 * rax_1`, which further reduces the randomness. This means the random seed can be easily predicted or brute-forced. Here's how an attacker could exploit this: The flag is XORed with random numbers:
`printf(format: "%02x", zx.q(rand()) ^ sx.d(*(sx.q(i) + &var_a8)))`

We can make the ff. solver to attempt brute forcing the random time encryption
```python
import time
import random

# Captured output from the program (hex string)
#output = "b84ca58fa5d947a8048c6f904b6f54a96a96d2bbaf93230a86fd5034b7292b3d50a5297313de8aee406eb5e86d861322f706"  # Replace with actual output from the program
output = "f75bdfeb23a6d4db93101d15e267201b9cb3ed32386393c56c94a24ee54ed338c8d89161f2baccbfc87e9bd842ddd0853fcc"
# Guess the seed (time^2)
current_time = int(time.time())  # Adjust this to match the time when the binary was run
for t in range(current_time - 50, current_time + 50):  # Brute force around current time
    seed = t * t
    random.seed(seed)
    
    # Generate the random sequence
    rand_values = [random.randint(0, 255) for _ in range(len(output) // 2)]
    
    # Try to recover the flag
    flag = ""
    for i in range(0, len(output), 2):
        byte = int(output[i:i+2], 16)  # Convert hex to integer
        flag += chr(byte ^ rand_values[i // 2])  # Reverse XOR
    print(f"Recovered flag: {flag}")

    if "flag{" in flag:  # Check if the flag looks correct
        print(f"Recovered flag: {flag}")
        break

```
## PseudoRand
This challenge is similar to the above in that it attempts to encrypt using a random number form a seed.

```python
#include <iostream>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>

int main() {
    // Setup connection
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    
    struct hostent *he = gethostbyname("offsec-chalbroker.osiris.cyber.nyu.edu");
    struct sockaddr_in server;
    memcpy(&server.sin_addr, he->h_addr_list[0], he->h_length);
    server.sin_family = AF_INET;
    server.sin_port = htons(1514);
    connect(sock, (struct sockaddr *)&server, sizeof(server));

    // Buffer for receiving data
    char buffer[1024] = {0};
    
    // Get initial prompt
    recv(sock, buffer, sizeof(buffer)-1, 0);
    std::cout << buffer;
    
    // Send NetID
    send(sock, "vqv9731\n", 9, 0);
    
    // Clear buffer and wait for response
    memset(buffer, 0, sizeof(buffer));
    recv(sock, buffer, sizeof(buffer)-1, 0);
    std::cout << buffer;
    
    // Generate and send random number
    srand(time(NULL) + 25);
    int random_number = rand();
    std::cout << "Random number: 0x" << std::hex << random_number << std::endl;
    
    std::string num_str = std::to_string(random_number) + "\n";
    send(sock, num_str.c_str(), num_str.length(), 0);

    // Get response
    while (true) {
        memset(buffer, 0, sizeof(buffer));
        int bytes = recv(sock, buffer, sizeof(buffer)-1, 0);
        if (bytes <= 0) break;
        std::cout << buffer;
    }

    close(sock);
    return 0;
}
```
## RSA-1
For this challenge, we are given an open endpoint to netcat to. Upon connection, we get the ff.:
![[Pasted image 20241216141420.png]]
The prompt gives us three values: `e`, `n`, and `c` respectively. From the given values, we can observe on key vulnerability -- `e` is $5$, which is very low. Because of this, the RSA encryption can be easily decrypted via brute force.

There exists tools just for this attack vector. 
### Python gmpy2
```python
import gmpy2
from gmpy2 import mpz
import binascii

def decrypt_rsa_low_exponent(e, n, c):
    # Convert C, e, and N to mpz type (gmpy2's large integer type)
    c = mpz(c)
    e = mpz(e)
    n = mpz(n)

    # Compute the modular root of C
    m = gmpy2.iroot(c, int(e))[0]  # We use iroot to compute the integer e-th root
    print(binascii.unhexlify(hex(m)[2:]))

# Example usage:

# Public key (e, N) and ciphertext C
e = 5
n = 652235754788208488948766427059446244047155448961740049215908706651362192713196441134867604941397778900539201535539172818009923896973111773063187145659895493484285295770071161891135540101201997564465674094759300893095387408889085262454140616387814014858488180239347137773022074397885683608693693725900429738846569162056426093957187020086252915185236844291361657358427715631224706045030880442928479567638123056588181177260766976132234243415197125829387801960934645957615960008238845382246115050920250176835080248868893163409517707598341240606281737170497604671313957628431597205352248022549109880511395293404403682921736119258067866285183948818295897414495102633327408818075530281972326138558023468671479889697368983072372439599391393011888728331143632043827695993407167880087561684399286379924922226476128555067743944579080484423956764439103224163596830794966902307184824287346288569324682052494175011000493466049940138485715201815776219528217913409836000149487726465357941294761047631964645286966812116348625611210978356117658015964449219732783593417287569270642890106184216808800213563407331566505923104131998870624936007292984849445159179921605048885807909400155987159763257776159548084806309809581656528458321058462578911536000141
c = 732466032403203463374878220140059105091651520977480015886219080123109003823825764362183672484468688599693489161327672895987971931252809396716800018479253710290112703242640982282493212778057701881062697898606918522743199199239372331377896423891231570666898856164541005987360219263018763396590309667830588763752415285141178751630520777840964366198443786687990736367618186235897338573365828644152532765094002596306840623067502338642018743024960732449950537084741956253301467951116603675544711742727679422051492684741589182467358628047086242957
# Perform decryption
M = decrypt_rsa_low_exponent(e, n, c)
```
### RsCtfTool 
We can utilize an open-source [RSA CTF cipher tool](https://github.com/RsaCtfTool/RsaCtfTool) to crack via brute force:
![[Pasted image 20241216143017.png]]
We specify our given inputs with `-e {e_Val} -n {n_Val} --decrypt {message_c}`
```bash
python3 RsaCtfTool.py -e 5 -n 02126918923901157207304751305648811475243912230913129592747216761952266334261469725318027569290860355705906573325265827613401908655928019019697710148480139551941252534638223501132880719581178288387743396516166201520558780320419949253284799964914105235030851131109892912995267525794927335472954488127769738398656622039351416175214793517173502518165625356622401077782551918332490295499595111240569172471528501834880482477313329009693144318829484931981149900276302879833331648958877757158001293917535149669624776148228248306725251948494332422378612042141576970989541404153742992973135610025849179510989358654075645032610332343684110419973620904192022552003615052617571370855060826892191140533080556877098998918848791871815387314127144848878344254941549611993536060375220224183554204586687876060117965635061853785000647088006813060585111397048371183282103131748934852698986773990383907357392424061454378648996871815840899993945640069556612603608216731469976884934779533479975480852283860629643240452849632853870826082671022967636426682513896277143878818390790760878480047309061001248721335288606588037787934363792410072087982521855771242047394630174976876740831791485156764706210116209511882779049781945979909332703090219800886001802601 --decrypt 732466032403203463374878220140059105091651520977480015886219080123109003823825764362183672484468688599693489161327672895987971931252809396716800018479253710290112703242640982282493212778057701881062697898606918522743199199239372331377896423891231570666898856164541005987360219263018763396590309667830588763752415285141178751630520777840964366198443786687990736367618186235897338573365828644152532765094002596306840623067502338642018743024960732449950537084741956253301467951116603675544711742727679422051492684741589182467358628047086242957
```
This gives us the flag.

## RSA-2
This challenge is similar to the previous [[Week13-Offsec#RSA-1]], however the message is double encrypted. When netcatting into the endpoint, we are given the following values:
![[Pasted image 20241216143652.png]]
There are three main things to note here:
- The `e` values are different, $e_1 \ne e_2$
- The `c` values are different, $c_1 \ne c_2$
- But the both `n` values are the same! That is to say:
$$
n_1 = n_2
$$
Since both `n` values are the same, we can take advantage of the common modulus for both messages as our attack vector! This usually happens when a user transmit the same encrypted message using the same modulus to two different users.

Recall that by [Bezout's Identity](https://en.wikipedia.org/wiki/B%C3%A9zout%27s_identity), for integers `x` and `y` in which `GCD(x, y) = d`, there exists some other integers `a` and `b` such that `ax + by = d`

Also recall that by the [Extended Euclidian Algorithm](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm), there exists some `a` and `b` such that `a * e_1 + b * e_2 = 1`

Using python and `gmpy2`, we can find out the values for `a` and `b`: 
```python
import gmpy2
import binascii

def attack(n, e1, e2, c1, c2):  
    # Extended Euclidean Algorithm to find a, b such that a*e1 + b*e2 = 1
    def extended_gcd(a, b):
        if b == 0:
            return a, 1, 0
        gcd, x1, y1 = extended_gcd(b, a % b)
        x = y1
        y = x1 - (a // b) * y1
        return gcd, x, y
    
    _, a, b = extended_gcd(e1, e2)
    
    # Handle negative coefficients
    if a < 0:
        c1 = gmpy2.invert(c1, n)  # Modular inverse of c1
        a = -a
    if b < 0:
        c2 = gmpy2.invert(c2, n)  # Modular inverse of c2
        b = -b
    
    # Compute the plaintext
    m = (gmpy2.powmod(c1, a, n) * gmpy2.powmod(c2, b, n)) % n  #`c_1^a * c_2^b = m (mod n)`
    print(binascii.unhexlify(hex(m)[2:]))
    return m

# input (sample) values
n = 1
e1 = 1
e2 = 1
c1 = 1
c2 = 1
message = attack(n, e1, e2, c1, c2)

print(f"Flag: {message}")
```

This gives us the flag.