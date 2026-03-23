# Attack Scenarios and Wazuh Alerts

## 1. Nmap Reconnaissance

**Tool:** Nmap  
**Command:**
```bash
sudo nmap -sS -sV 192.168.56.102
```

**What it does:** SYN scan - sends TCP SYN packets without completing handshake. Stealthy reconnaissance to detect open ports and service versions.

**Wazuh alerts:**
- Web server 400 error code - rule 31101, level 5
- Apache access log entries from scanner IP

**MITRE ATT&CK:** T1046 - Network Service Discovery

---

## 2. SSH Brute Force

**Tool:** Hydra  
**Command:**
```bash
hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.56.102 -t 4 -I
```
<img width="1280" height="606" alt="image" src="https://github.com/user-attachments/assets/0d9ee89b-450b-47f9-885f-6672428148f3" />
**What it does:** Dictionary attack against SSH - tries 14 million passwords from rockyou.txt wordlist.

**Wazuh alerts:**
- `sshd: authentication failed` - rule 5760, level 5 - each failed attempt
- `syslog: User missed the password more than one time` - rule 2502, level 10 - aggregated brute force detection

**MITRE ATT&CK:** T1110 - Brute Force, Credential Access

**Active Response triggered:**
- Rule 5763 fired after threshold reached
- Wazuh executed `firewall-drop` command automatically
- Kali IP 192.168.56.103 blocked via iptables for 180 seconds
- Hydra received `Connection timeout` - attack stopped automatically

---

## 3. Web Application Scanning - Nikto

**Tool:** Nikto  
**Command:**
```bash
nikto -h http://192.168.56.102
```

**What it does:** Aggressive web server scanner - checks for misconfigurations, outdated software, missing security headers, known vulnerabilities.

**Findings:**
- Apache/2.4.58 version exposed - attacker knows exact target
- Missing X-Frame-Options header - clickjacking vulnerability
- Missing X-Content-Type-Options - MIME sniffing attacks possible
- ETag inode leak - CVE-2003-1418, filesystem information disclosure

<img width="1242" height="902" alt="image" src="https://github.com/user-attachments/assets/653a0863-2fca-4a6f-932b-fea12ffc7c12" />


**Wazuh alerts:**
- `Web server 400 error code` - rule 31101, level 5
- `Multiple web server 400 error codes` - rule 31151, level 10
- Total: 8089 events generated

**MITRE ATT&CK:** T1595 - Active Scanning, Vulnerability Scanning

---

## Alert Summary

<img width="1568" height="690" alt="image" src="https://github.com/user-attachments/assets/80713be6-ff45-41be-b3f2-6a38696401f0" />


| Attack | Tool | Rule ID | Level | MITRE |
|--------|------|---------|-------|-------|
| Reconnaissance | Nmap | 31101 | 5 | T1046 |
| SSH Brute Force | Hydra | 5760, 2502 | 5, 10 | T1110 |
| Active Response | Wazuh | 5763 | 10 | T1110 |
| Web Scanning | Nikto | 31101, 31151 | 5, 10 | T1595 |

<img width="1280" height="806" alt="image" src="https://github.com/user-attachments/assets/2db8f48f-1bbe-4a5d-b2c3-6fbe3fec135c" />
