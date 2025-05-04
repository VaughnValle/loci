---
tags:
  - pen-testing
---
*by Vaughn Valle*

Before we start, I want to make sure both hosts are reachable from each other.
### Testing connectivity for both machines
#### Arch Machine
![[Pasted image 20250303175542.png]]
#### Kali VM
![[Pasted image 20250303175518.png]]

Now we ping from both sides
![[Pasted image 20250303175733.png]]
![[Pasted image 20250303175714.png]]

Everything looks good. Now we can start with the lab

For the following sections, our setup would be 
* a Kali Linux system running as a  Proxmox VM as our *host machine*
	* IP: `192.168.1.200`
* an Arch Linux system running as a Proxmox LXC as our *target machine*
	* IP: `192.168.1.179`
### NMap Scanning
**1. Scan the target for connectivity only, no ports. Let's make sure we can access it.**

```bash
nmap -sn 192.168.1.179 
```

- `-sn`: This option performs a ping scan (host discovery) without port scanning. It checks if the target is online.
![[Pasted image 20250303181109.png]]

**2. Scan the target, scan all ports, TCP connect scan. What ports are open?**

```bash
nmap -sT -p- 192.168.1.179
```

- `-sT`: This specifies a TCP connect scan. It completes the full TCP three-way handshake, making it easily detectable.
- `-p-`: This tells `nmap` to scan all 65535 ports.
![[Pasted image 20250303181416.png]]

**3. Scan the top 20 ports with UDP only, and have nmap show you the reason. Did you see any new ports open?**

```bash
nmap -sU --top-ports 20 --reason 192.168.1.179
```

- `-sU`: This specifies a UDP scan.
- `--top-ports 20`: This tells `nmap` to scan the top 20 most common UDP ports.
- `--reason`: This option makes `nmap` display the reason a port is in a particular state (open, closed, filtered).
![[Pasted image 20250303183023.png]]

**4. Two scans: scan the top 20 ports, have nmap show you the reason, make the timings Insane (5) and then Polite (2). Anything different?**

```bash
nmap -T5 --top-ports 20 --reason 192.168.1.179
nmap -T2 --top-ports 20 --reason 192.168.1.179
```

- `-T5`: Insane timing template. Sends packets very aggressively, assuming a fast and reliable network.
![[Pasted image 20250303183924.png]]
- `-T2`: Polite timing template. Slows down the scan to avoid overwhelming the target.
![[Pasted image 20250303184142.png]]

Here we can see that with `-T5` timing, the `nmap` scan finished in `13.21 seconds` while with the `-T2` timing, the scan finished in `21.58` seconds. This aligns with our timing template predictions.

**5. Scan all open ports only, Normal timing, TCP connect, enable version scanning, include reason, and output to an XML file.**

```bash
nmap -sT -sV --reason -oX output.xml 192.168.1.179
```

- `-sT`: TCP connect scan (as before).
- `-sV`: Enables version detection, which tries to determine the service and version running on open ports.
- `--reason`: Displays the reason for port states.
- `-oX output.xml`: Outputs the scan results in XML format to a file named `output.xml`. You can change the filename as needed.
- `-T3`: Normal timing is the default, so you don't need to specify it, but you can add it for clarity if you wish.
![[Pasted image 20250303184540.png]]
### SCP errors (Enabling SSH on Kali)
As I was trying to remotely transfer my `output.xml` file from the target machine to my personal Macbook via [scp](https://linux.die.net/man/1/scp), I was getting a `Connection Refused` on Port 22. I found out that Kali does not start the ssh service by default for security reasons and had to enable it via 
```bash
sudo service ssh start
```
And confirmed that it was enabled and running with
```bash
sudo service ssh status
```
![[Pasted image 20250303223850.png]]
I've attached the `output.xml` file below.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE nmaprun>
<?xml-stylesheet href="file:///usr/share/nmap/nmap.xsl" type="text/xsl"?>
<!-- Nmap 7.94SVN scan initiated Mon Mar  3 18:45:07 2025 as: /usr/lib/nmap/nmap -&#45;privileged -sT -sV -&#45;reason -oX output.xml 192.168.1.179 -->
<nmaprun scanner="nmap" args="/usr/lib/nmap/nmap -&#45;privileged -sT -sV -&#45;reason -oX output.xml 192.168.1.179" start="1741045507" startstr="Mon Mar  3 18:45:07 2025" version="7.94SVN" xmloutputversion="1.05">
<scaninfo type="connect" protocol="tcp" numservices="1000" services="1,3-4,6-7,9,13,17,19-26,30,32-33,37,42-43,49,53,70,79-85,88-90,99-100,106,109-111,113,119,125,135,139,143-144,146,161,163,179,199,211-212,222,254-256,259,264,280,301,306,311,340,366,389,406-407,416-417,425,427,443-445,458,464-465,481,497,500,512-515,524,541,543-545,548,554-555,563,587,593,616-617,625,631,636,646,648,666-668,683,687,691,700,705,711,714,720,722,726,749,765,777,783,787,800-801,808,843,873,880,888,898,900-903,911-912,981,987,990,992-993,995,999-1002,1007,1009-1011,1021-1100,1102,1104-1108,1110-1114,1117,1119,1121-1124,1126,1130-1132,1137-1138,1141,1145,1147-1149,1151-1152,1154,1163-1166,1169,1174-1175,1183,1185-1187,1192,1198-1199,1201,1213,1216-1218,1233-1234,1236,1244,1247-1248,1259,1271-1272,1277,1287,1296,1300-1301,1309-1311,1322,1328,1334,1352,1417,1433-1434,1443,1455,1461,1494,1500-1501,1503,1521,1524,1533,1556,1580,1583,1594,1600,1641,1658,1666,1687-1688,1700,1717-1721,1723,1755,1761,1782-1783,1801,1805,1812,1839-1840,1862-1864,1875,1900,1914,1935,1947,1971-1972,1974,1984,1998-2010,2013,2020-2022,2030,2033-2035,2038,2040-2043,2045-2049,2065,2068,2099-2100,2103,2105-2107,2111,2119,2121,2126,2135,2144,2160-2161,2170,2179,2190-2191,2196,2200,2222,2251,2260,2288,2301,2323,2366,2381-2383,2393-2394,2399,2401,2492,2500,2522,2525,2557,2601-2602,2604-2605,2607-2608,2638,2701-2702,2710,2717-2718,2725,2800,2809,2811,2869,2875,2909-2910,2920,2967-2968,2998,3000-3001,3003,3005-3007,3011,3013,3017,3030-3031,3052,3071,3077,3128,3168,3211,3221,3260-3261,3268-3269,3283,3300-3301,3306,3322-3325,3333,3351,3367,3369-3372,3389-3390,3404,3476,3493,3517,3527,3546,3551,3580,3659,3689-3690,3703,3737,3766,3784,3800-3801,3809,3814,3826-3828,3851,3869,3871,3878,3880,3889,3905,3914,3918,3920,3945,3971,3986,3995,3998,4000-4006,4045,4111,4125-4126,4129,4224,4242,4279,4321,4343,4443-4446,4449,4550,4567,4662,4848,4899-4900,4998,5000-5004,5009,5030,5033,5050-5051,5054,5060-5061,5080,5087,5100-5102,5120,5190,5200,5214,5221-5222,5225-5226,5269,5280,5298,5357,5405,5414,5431-5432,5440,5500,5510,5544,5550,5555,5560,5566,5631,5633,5666,5678-5679,5718,5730,5800-5802,5810-5811,5815,5822,5825,5850,5859,5862,5877,5900-5904,5906-5907,5910-5911,5915,5922,5925,5950,5952,5959-5963,5987-5989,5998-6007,6009,6025,6059,6100-6101,6106,6112,6123,6129,6156,6346,6389,6502,6510,6543,6547,6565-6567,6580,6646,6666-6669,6689,6692,6699,6779,6788-6789,6792,6839,6881,6901,6969,7000-7002,7004,7007,7019,7025,7070,7100,7103,7106,7200-7201,7402,7435,7443,7496,7512,7625,7627,7676,7741,7777-7778,7800,7911,7920-7921,7937-7938,7999-8002,8007-8011,8021-8022,8031,8042,8045,8080-8090,8093,8099-8100,8180-8181,8192-8194,8200,8222,8254,8290-8292,8300,8333,8383,8400,8402,8443,8500,8600,8649,8651-8652,8654,8701,8800,8873,8888,8899,8994,9000-9003,9009-9011,9040,9050,9071,9080-9081,9090-9091,9099-9103,9110-9111,9200,9207,9220,9290,9415,9418,9485,9500,9502-9503,9535,9575,9593-9595,9618,9666,9876-9878,9898,9900,9917,9929,9943-9944,9968,9998-10004,10009-10010,10012,10024-10025,10082,10180,10215,10243,10566,10616-10617,10621,10626,10628-10629,10778,11110-11111,11967,12000,12174,12265,12345,13456,13722,13782-13783,14000,14238,14441-14442,15000,15002-15004,15660,15742,16000-16001,16012,16016,16018,16080,16113,16992-16993,17877,17988,18040,18101,18988,19101,19283,19315,19350,19780,19801,19842,20000,20005,20031,20221-20222,20828,21571,22939,23502,24444,24800,25734-25735,26214,27000,27352-27353,27355-27356,27715,28201,30000,30718,30951,31038,31337,32768-32785,33354,33899,34571-34573,35500,38292,40193,40911,41511,42510,44176,44442-44443,44501,45100,48080,49152-49161,49163,49165,49167,49175-49176,49400,49999-50003,50006,50300,50389,50500,50636,50800,51103,51493,52673,52822,52848,52869,54045,54328,55055-55056,55555,55600,56737-56738,57294,57797,58080,60020,60443,61532,61900,62078,63331,64623,64680,65000,65129,65389"/>
<verbose level="0"/>
<debugging level="0"/>
<hosthint><status state="up" reason="arp-response" reason_ttl="0"/>
<address addr="192.168.1.179" addrtype="ipv4"/>
<address addr="BC:24:11:F6:15:40" addrtype="mac"/>
<hostnames>
</hostnames>
</hosthint>
<host starttime="1741045520" endtime="1741045520"><status state="up" reason="arp-response" reason_ttl="0"/>
<address addr="192.168.1.179" addrtype="ipv4"/>
<address addr="BC:24:11:F6:15:40" addrtype="mac"/>
<hostnames>
</hostnames>
<ports><extraports state="closed" count="999">
<extrareasons reason="conn-refused" count="999" proto="tcp" ports="1,3-4,6-7,9,13,17,19-21,23-26,30,32-33,37,42-43,49,53,70,79-85,88-90,99-100,106,109-111,113,119,125,135,139,143-144,146,161,163,179,199,211-212,222,254-256,259,264,280,301,306,311,340,366,389,406-407,416-417,425,427,443-445,458,464-465,481,497,500,512-515,524,541,543-545,548,554-555,563,587,593,616-617,625,631,636,646,648,666-668,683,687,691,700,705,711,714,720,722,726,749,765,777,783,787,800-801,808,843,873,880,888,898,900-903,911-912,981,987,990,992-993,995,999-1002,1007,1009-1011,1021-1100,1102,1104-1108,1110-1114,1117,1119,1121-1124,1126,1130-1132,1137-1138,1141,1145,1147-1149,1151-1152,1154,1163-1166,1169,1174-1175,1183,1185-1187,1192,1198-1199,1201,1213,1216-1218,1233-1234,1236,1244,1247-1248,1259,1271-1272,1277,1287,1296,1300-1301,1309-1311,1322,1328,1334,1352,1417,1433-1434,1443,1455,1461,1494,1500-1501,1503,1521,1524,1533,1556,1580,1583,1594,1600,1641,1658,1666,1687-1688,1700,1717-1721,1723,1755,1761,1782-1783,1801,1805,1812,1839-1840,1862-1864,1875,1900,1914,1935,1947,1971-1972,1974,1984,1998-2010,2013,2020-2022,2030,2033-2035,2038,2040-2043,2045-2049,2065,2068,2099-2100,2103,2105-2107,2111,2119,2121,2126,2135,2144,2160-2161,2170,2179,2190-2191,2196,2200,2222,2251,2260,2288,2301,2323,2366,2381-2383,2393-2394,2399,2401,2492,2500,2522,2525,2557,2601-2602,2604-2605,2607-2608,2638,2701-2702,2710,2717-2718,2725,2800,2809,2811,2869,2875,2909-2910,2920,2967-2968,2998,3000-3001,3003,3005-3007,3011,3013,3017,3030-3031,3052,3071,3077,3128,3168,3211,3221,3260-3261,3268-3269,3283,3300-3301,3306,3322-3325,3333,3351,3367,3369-3372,3389-3390,3404,3476,3493,3517,3527,3546,3551,3580,3659,3689-3690,3703,3737,3766,3784,3800-3801,3809,3814,3826-3828,3851,3869,3871,3878,3880,3889,3905,3914,3918,3920,3945,3971,3986,3995,3998,4000-4006,4045,4111,4125-4126,4129,4224,4242,4279,4321,4343,4443-4446,4449,4550,4567,4662,4848,4899-4900,4998,5000-5004,5009,5030,5033,5050-5051,5054,5060-5061,5080,5087,5100-5102,5120,5190,5200,5214,5221-5222,5225-5226,5269,5280,5298,5357,5405,5414,5431-5432,5440,5500,5510,5544,5550,5555,5560,5566,5631,5633,5666,5678-5679,5718,5730,5800-5802,5810-5811,5815,5822,5825,5850,5859,5862,5877,5900-5904,5906-5907,5910-5911,5915,5922,5925,5950,5952,5959-5963,5987-5989,5998-6007,6009,6025,6059,6100-6101,6106,6112,6123,6129,6156,6346,6389,6502,6510,6543,6547,6565-6567,6580,6646,6666-6669,6689,6692,6699,6779,6788-6789,6792,6839,6881,6901,6969,7000-7002,7004,7007,7019,7025,7070,7100,7103,7106,7200-7201,7402,7435,7443,7496,7512,7625,7627,7676,7741,7777-7778,7800,7911,7920-7921,7937-7938,7999-8002,8007-8011,8021-8022,8031,8042,8045,8080-8090,8093,8099-8100,8180-8181,8192-8194,8200,8222,8254,8290-8292,8300,8333,8383,8400,8402,8443,8500,8600,8649,8651-8652,8654,8701,8800,8873,8888,8899,8994,9000-9003,9009-9011,9040,9050,9071,9080-9081,9090-9091,9099-9103,9110-9111,9200,9207,9220,9290,9415,9418,9485,9500,9502-9503,9535,9575,9593-9595,9618,9666,9876-9878,9898,9900,9917,9929,9943-9944,9968,9998-10004,10009-10010,10012,10024-10025,10082,10180,10215,10243,10566,10616-10617,10621,10626,10628-10629,10778,11110-11111,11967,12000,12174,12265,12345,13456,13722,13782-13783,14000,14238,14441-14442,15000,15002-15004,15660,15742,16000-16001,16012,16016,16018,16080,16113,16992-16993,17877,17988,18040,18101,18988,19101,19283,19315,19350,19780,19801,19842,20000,20005,20031,20221-20222,20828,21571,22939,23502,24444,24800,25734-25735,26214,27000,27352-27353,27355-27356,27715,28201,30000,30718,30951,31038,31337,32768-32785,33354,33899,34571-34573,35500,38292,40193,40911,41511,42510,44176,44442-44443,44501,45100,48080,49152-49161,49163,49165,49167,49175-49176,49400,49999-50003,50006,50300,50389,50500,50636,50800,51103,51493,52673,52822,52848,52869,54045,54328,55055-55056,55555,55600,56737-56738,57294,57797,58080,60020,60443,61532,61900,62078,63331,64623,64680,65000,65129,65389"/>
</extraports>
<port protocol="tcp" portid="22"><state state="open" reason="syn-ack" reason_ttl="0"/><service name="ssh" product="OpenSSH" version="9.9" extrainfo="protocol 2.0" method="probed" conf="10"><cpe>cpe:/a:openbsd:openssh:9.9</cpe></service></port>
</ports>
<times srtt="313" rttvar="287" to="100000"/>
</host>
<runstats><finished time="1741045520" timestr="Mon Mar  3 18:45:20 2025" summary="Nmap done at Mon Mar  3 18:45:20 2025; 1 IP address (1 host up) scanned in 13.40 seconds" elapsed="13.40" exit="success"/><hosts up="1" down="0" total="1"/>
</runstats>
</nmaprun>
```

### Using recon-ng to gather subdomains from Boozt's site to test out EyeWitness
#### Start recon-ng
```bash
recon-ng
```
![[Pasted image 20250303224150.png]]
#### Create a new workspace
```recon-ng
workspaces create boozt
```
![[Pasted image 20250303224212.png]]
#### Add the domain to the domains table
```
db insert domains
boozt.com
```

#### Install and use passive modules (no brute force)
```
marketplace install recon/domains-hosts/hackertarget
marketplace install recon/domains-hosts/threatcrowd
marketplace install recon/domains-hosts/certificate_transparency
marketplace install recon/domains-hosts/ssl_san
```

![[Pasted image 20250303233051.png]]
#### Run the modules
```
modules load recon/domains-hosts/hackertarget
run
```
![[Pasted image 20250303233144.png]]
```
modules load recon/domains-hosts/threatcrowd
run
```
![[Pasted image 20250303233249.png]]

```bash
modules load recon/domains-hosts/certificate_transparency
run
```
![[Pasted image 20250303233313.png]]

```bash
modules load recon/domains-hosts/ssl_san
run
```
![[Pasted image 20250303233353.png]]
#### Show the discovered hosts (limit to first 50 hosts)
```bash
show hosts | grep "boozt.com" | head -n 50
```
![[Pasted image 20250303233720.png]]
#### Export results
```
spool start /tmp/boozt_lab3.txt
show hosts | grep "boozt.com" | head -n 50
spool stop
```
![[Pasted image 20250303233836.png]]

Using [scp](https://linux.die.net/man/1/scp), I remotely transferred the `boozt_lab3.txt` to my MacBook and attached the file contents below

```txt
[34m[*][m Spooling output to '/tmp/boozt_lab3.txt'.
[recon-ng][boozt][ssl_san] > show hosts | grep "boozt.com" | head -n 50

  +------------------------------------------------------------------------------------------------------------------------------------+
  | rowid |             host             |   ip_address   | region | country | latitude | longitude | notes |          module          |
  +------------------------------------------------------------------------------------------------------------------------------------+
  | 1     | click.boozt.com              | 104.17.222.122 |        |         |          |           |       | hackertarget             |
  | 2     | email.boozt.com              | 136.147.129.27 |        |         |          |           |       | hackertarget             |
  | 3     | click.email.boozt.com        | 13.111.45.146  |        |         |          |           |       | hackertarget             |
  | 4     | mta.email.boozt.com          | 13.111.16.180  |        |         |          |           |       | hackertarget             |
  | 5     | mta2.email.boozt.com         | 13.111.4.66    |        |         |          |           |       | hackertarget             |
  | 6     | view.email.boozt.com         | 13.111.46.146  |        |         |          |           |       | hackertarget             |
  | 7     | fb.boozt.com                 | 104.17.222.122 |        |         |          |           |       | hackertarget             |
  | 8     | fpt.boozt.com                | 35.227.225.212 |        |         |          |           |       | hackertarget             |
  | 9     | m.boozt.com                  | 104.17.224.122 |        |         |          |           |       | hackertarget             |
  | 10    | nw.boozt.com                 | 104.17.226.122 |        |         |          |           |       | hackertarget             |
  | 11    | o2.ptr4956.boozt.com         | 149.72.189.164 |        |         |          |           |       | hackertarget             |
  | 12    | sendgrid.boozt.com           | 104.17.225.122 |        |         |          |           |       | hackertarget             |
  | 13    | o1.sendgrid.boozt.com        | 50.31.61.173   |        |         |          |           |       | hackertarget             |
  | 14    | sp.boozt.com                 | 104.17.224.122 |        |         |          |           |       | hackertarget             |
  | 15    | sp-dev.boozt.com             | 104.17.223.122 |        |         |          |           |       | hackertarget             |
  | 16    | t.boozt.com                  | 104.17.223.122 |        |         |          |           |       | hackertarget             |
  | 17    | www.boozt.com                | 104.17.222.122 |        |         |          |           |       | hackertarget             |
  | 18    | image.email.boozt.com        |                |        |         |          |           |       | certificate_transparency |
  | 19    | *.boozt.com                  |                |        |         |          |           |       | certificate_transparency |
  | 20    | boozt.com                    |                |        |         |          |           |       | certificate_transparency |
  | 21    | *.spk.boozt.com              |                |        |         |          |           |       | certificate_transparency |
  | 22    | spk.boozt.com                |                |        |         |          |           |       | certificate_transparency |
  | 23    | ia.boozt.com                 |                |        |         |          |           |       | certificate_transparency |
  | 24    | links.boozt.com              |                |        |         |          |           |       | certificate_transparency |
  | 25    | ib.boozt.com                 |                |        |         |          |           |       | certificate_transparency |
  | 26    | bztesx01.warehouse.boozt.com |                |        |         |          |           |       | certificate_transparency |
  | 27    | bztesx02.warehouse.boozt.com |                |        |         |          |           |       | certificate_transparency |
  | 28    | bztvc01.warehouse.boozt.com  |                |        |         |          |           |       | certificate_transparency |
  | 29    | delivery-time.boozt.com      |                |        |         |          |           |       | certificate_transparency |
  | 30    | www.t.boozt.com              |                |        |         |          |           |       | certificate_transparency |
  | 31    | www.parcel-api.boozt.com     |                |        |         |          |           |       | certificate_transparency |
  | 32    | parcel-api.boozt.com         |                |        |         |          |           |       | certificate_transparency |
  | 33    | www.parcel.api.boozt.com     |                |        |         |          |           |       | certificate_transparency |
  | 34    | parcel.api.boozt.com         |                |        |         |          |           |       | certificate_transparency |
  | 35    | ag.boozt.com                 |                |        |         |          |           |       | certificate_transparency |
  +------------------------------------------------------------------------------------------------------------------------------------+

[34m[*][m 35 rows returned
[recon-ng][boozt][ssl_san] > spool stop
[34m[*][m Spooling stopped. Output saved to '/tmp/boozt_lab3.txt'.
```
This is the same output we had from the `recon-ng` console. I've attached a screenshot to make it more readable
![[Pasted image 20250303234148.png]]