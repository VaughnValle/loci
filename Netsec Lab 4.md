# Firewall Exploration
_by Vaughn Valle_

## Task 1: Implementing a Simple Firewall

### Task 1A: Implement a Simple Kernel Module
Included in the lab setup files is a file named `hello.c` which contains the following:

```c
#include <linux/module.h>
#include <linux/kernel.h>
int initialization(void){
	printk(KERN_INFO "Hello World!\n");
	return 0;
}
void cleanup(void){
	printk(KERN_INFO "Bye-bye World!.\n");
}
module_init(initialization);
module_exit(cleanup);
```

Now we create the `Makefile` to compile the C program above into a loadable kernel module:
```bash
obj-m += hello.o

all:
make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
```
Once created, we just run `make` to generate the kernel module.

After completion, the generated kernel module is in `hello.ko`. Since I'm on an Apple Silicon Machine using VMWare Fusion for virtualization, I needed to install gcc on the VM via
```bash
sudo apt install gcc-12
```
Once installed, we can load the module, list all loaded modules, and then remove the module we just loaded in.
```bash
$ sudo insmod hello.ko (inserting a module)
$ lsmod | grep hello (list modules)
$ sudo rmmod hello (remove the module)
$ dmesg (check the messages)
$ sudo dmesg (in Ubuntu 22.04, this command requires superuser privilege)
```
Below is a screenshot of the terminal `dmesg` output
**MISSING**

### Task 1B: Implement a Simple Firewall Using Netfilter
Given in `Labsetup-arm.zip` is a file called `seedFilter.c` in `Files/packet_filter`

In the same folder is an already provided `Makefile`. We can use this to load `seedFilter.c` into a loadable kernel module by running `make`.

Once loaded into the kernel, let's test that the firewall works. We'll know that it work if the following is blocked:
```bash
dig @8.8.8.8 www.example.com
```
If we get a response, then the firewall didn't work. However, it works as seen in the screenshot

>[! error] Image file cannot be found

Now let's edit `seedFilter.c` to add some extra hooks
```cpp
NF_INET_PRE_ROUTING
NF_INET_LOCAL_IN
NF_INET_FORWARD
NF_INET_LOCAL_OUT
NF_INET_POST_ROUTING
```
Here are the results:
>[! error] Image file cannot be found
```bash
ping 10.9.0.1
telnet 10.9.0.1
```
Here are the results:
>[! error] Image file cannot be found
## Task 2: Experimenting with Stateless Firewall Rules
### Task 2A: Protecting the Router
In this task we are implementing the following firewall rules
```bash
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -P OUTPUT DROP
iptables -P INPUT DROP
```
The explanation for each rule chronologically is as follows:
1. Allows all inbound ICMP ECHO REQUEST packets
2. Allows all outbound ICMP ECHO REPLY packets
3. Drops all other outbound traffic
4. Drops all other inbound traffic
This explains why we can ping the router but cannot telnet into it since `ping` uses ICMP. The following results support this
>[! error] Image file cannot be found

Afterwards, we restore the table by cleaning it up
```bash
iptables -F
iptables -P OUTPUT ACCEPT
iptables -P INPUT ACCEPT
```
### Task 2B: Protecting the Internal Network
In this task, we would like to achieve the following:
1. Outside hosts cannot ping internal hosts.
2. Outside hosts can ping the router.
3. Internal hosts can ping outside hosts.
4. All other packets between the internal and external networks should be blocked.
From this, the following rules were created
```bash
# Reset iptables rules
iptables -F
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

# Block ICMP traffic from outside to inside
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Allow ICMP traffic from inside to outside
iptables -A OUTPUT -p icmp -j ACCEPT

# Allow ICMP traffic from outside to router
iptables -A INPUT -p icmp --icmp-type echo-request -s <router_IP> -j ACCEPT

# Block all other traffic from outside to inside
iptables -A INPUT -j DROP
```
Results:
>[! error] Image file cannot be found
### Task 2C: Protecting Internal Servers
In this task, we would like to achieve the following:
1. All the internal hosts run a telnet server (listening to port 23). Outside hosts can only access the telnet server on 192.168.60.5, not the other internal hosts.
2. Outside hosts cannot access other internal servers.
3. Internal hosts can access all the internal servers.
4. Internal hosts cannot access external servers.
5. In this task, the connection tracking mechanism is not allowed. It will be used in a later task.
Thus, we can create the following rules:
```bash
# Reset iptables rules
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP

# Allow telnet access to 192.168.60.5 from anywhere
iptables -A INPUT -p tcp --dport 23 -d 192.168.60.5 -j ACCEPT

# Block all telnet access to other internal hosts
iptables -A INPUT -p tcp --dport 23 -d 192.168.60.0/24 -j DROP

# Allow all traffic from internal hosts to internal hosts
iptables -A INPUT -s 192.168.60.0/24 -j ACCEPT

# Block all other traffic from outside to inside
iptables -A INPUT -j DROP

# Block all traffic from internal hosts to outside
iptables -A OUTPUT -j DROP
```
Results:
>[! error] Image file cannot be found
## Task 3: Connection Tracking and Stateful Firewall

### Task 3.A: Experiment with the Connection Tracking

Note that we can heck the connection tracking information on the router container using:
```bash
conntrack -L
```

Now we check the connection for each experiment

For ICMP:
```bash
# On 10.9.0.5, send out ICMP packets
ping 192.168.60.5
```
Results:
>[! error] Image file cannot be found

For UDP:
```bash
# On 192.168.60.5, start a netcat UDP server
nc -lu 9090

# On 10.9.0.5, send out UDP packets
nc -u 192.168.60.5 9090

#<type something, then hit return>
```
Results:
>[! error] Image file cannot be found

For TCP:
```bash
# On 192.168.60.5, start a netcat TCP server
nc -l 9090

#On 10.9.0.5, send out TCP packets
nc 192.168.60.5 9090

#<type something, then hit return>
```
Results:
>[! error] Image file cannot be found
### Task 3.B: Setting Up a Stateful Firewall
In this task we are rewriting the rules in [[Netsec Lab 4#Task 2C Protecting Internal Servers]] to **allow internal hosts to visit any external server**

Here's how I implemented it without using connection tracking:
```bash
# Reset iptables rules
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP

# Allow telnet access to 192.168.60.5 from anywhere
iptables -A INPUT -p tcp --dport 23 -d 192.168.60.5 -j ACCEPT

# Block all telnet access to other internal hosts
iptables -A INPUT -p tcp --dport 23 -d 192.168.60.0/24 -j DROP

# Allow all traffic from internal hosts to internal hosts
iptables -A INPUT -s 192.168.60.0/24 -j ACCEPT

# Block all other traffic from outside to inside
iptables -A INPUT -j DROP

# Allow all traffic from internal hosts to outside
iptables -A OUTPUT -s 192.168.60.0/24 -j ACCEPT
```
Results:
>[! error] Image file cannot be found

And here's the same implementation but using connection tracking:
```bash
# Reset iptables rules
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Enable conntrack
iptables -N CONNTRACK
iptables -A INPUT -j CONNTRACK
iptables -A OUTPUT -j CONNTRACK
iptables -A FORWARD -j CONNTRACK

# Allow telnet access to 192.168.60.5 from anywhere
iptables -A INPUT -p tcp --dport 23 -d 192.168.60.5 -j ACCEPT

# Block all telnet access to other internal hosts
iptables -A INPUT -p tcp --dport 23 -d 192.168.60.0/24 -j DROP

# Allow all traffic from internal hosts to internal hosts
iptables -A INPUT -s 192.168.60.0/24 -j ACCEPT

# Block all other traffic from outside to inside
iptables -A INPUT -j DROP

# Allow outgoing traffic from internal hosts to external servers
iptables -A FORWARD -s 192.168.60.0/24 -j ACCEPT

# Allow return traffic for established connections
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```
Results:
>[! error] Image file cannot be found

With this, we have successfully setup a Stateful Firewall

## Task 4: Limiting Network Traffic
**First Rule:**
```bash
iptables -A FORWARD -s 10.9.0.5 -m limit \
--limit 10/minute --limit-burst 5 -j ACCEPT
```
This rule limits the number of packets from 10.9.0.5 to 10 per minute, with a burst size of 5. This means that initially, 5 packets can be sent immediately, and then the rate is limited to 10 packets per minute.

**Second Rule:**
```bash
iptables -A FORWARD -s 10.9.0.5 -j DROP
```
This rule unconditionally drops all packets from 10.9.0.5.

**Without the Second Rule:**
When we start pinging from 10.9.0.5 to 192.168.60.5, the first 5 pings will be allowed immediately due to the burst size. However, after the initial burst, the rate will be limited to 10 pings per minute. We can see a delay between each ping, ensuring that the rate doesn't exceed the limit.

Results:
>[! error] Image file cannot be found

**With the Second Rule:**
>[! error] Image file cannot be found

The second rule will unconditionally drop all packets from 10.9.0.5, regardless of the rate limit set by the first rule. The second rule is not strictly necessary in this scenario. The first rule, with its rate limiting and burst size, effectively controls the traffic from 10.9.0.5. However, there are specific use cases where the second rule can be useful. 

If we want to completely block traffic from a specific source, the second rule provides a definitive solution. Also, in case of a security breach or other emergency, the second rule can be quickly added to immediately halt all traffic from the source. This is because the second rule is basically a "deny-all" rule for all traffic from 10.9.0.5.

## Task 5: Load Balancing
We're tasked with creating a load balancing setup using iptables rules to distribute UDP traffic evenly across three internal servers: 192.168.60.5, 192.168.60.6, and 192.168.60.7.

**Using nth Mode (Round-Robin):**
To distribute traffic evenly among the three servers, we need to modify the `nth` mode rule to cycle through all three servers. Here's the revised rule set:
```bash
iptables -t nat -A PREROUTING -p udp --dport 8080 \
-m statistic --mode nth --every 3 --packet 0 \
-j DNAT --to-destination 192.168.60.5:8080

iptables -t nat -A PREROUTING -p udp --dport 8080 \
-m statistic --mode nth --every 3 --packet 1 \
-j DNAT --to-destination 192.168.60.6:8080

iptables -t nat -A PREROUTING -p udp --dport 8080 \
-m statistic --mode nth --every 3 --packet 2 \
-j DNAT --to-destination 192.168.60.7:8080
```
Where:
- **Rule 1:** Directs every 3rd packet to the first server (192.168.60.5).
- **Rule 2:** Directs every 3rd packet, starting from the second packet, to the second server (192.168.60.6).
- **Rule 3:** Directs every 3rd packet, starting from the third packet, to the third server (192.168.60.7).

This ensures a round-robin distribution of traffic across the three servers.

**Using Random Mode:**
To use the `random` mode to distribute traffic more evenly, we can create three rules, each with a probability of 1/3 (this value is based on the fact that we are load-balancing 3 UDP servers from 100 divided by 3):
```bash
iptables -t nat -A PREROUTING -p udp --dport 8080 \
-m statistic --mode random --probability 0.33 \
-j DNAT --to-destination 192.168.60.5:8080

iptables -t nat -A PREROUTING -p udp --dport 8080 \
-m statistic --mode random --probability 0.33 \
-j DNAT --to-destination 192.168.60.6:8080

iptables -t nat -A PREROUTING -p udp --dport 8080 \
-m statistic --mode random --probability 0.33 \
-j DNAT --to-destination 192.168.60.7:8080
```

 Each rule has a 33% chance of selecting a packet and redirecting it to the corresponding server. Over time, this random selection should result in a fairly even distribution of traffic across the three servers.

While the `random` mode can provide a more flexible and potentially fairer distribution, the `nth` mode is often preferred for its deterministic nature, especially in scenarios where predictable traffic distribution is important.