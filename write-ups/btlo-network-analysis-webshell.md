# BTLO - Network Analysis: Web Shell

## 1. Overview
- blueteamlabs.online, 17.03.2026, Scenario:
The SOC received an alert in their SIEM for ‘Local to Local Port Scanning’ where an internal private IP began scanning another internal system. Can you investigate and determine if this activity is malicious or not? You have been provided a PCAP, investigate using any tools you wish

## 2. Tools Used
- Wireshark 4.6.3

## 3. Analysis

### 3.1 Reconnaissance
- Attacker is - 10.251.96.4. TCP SYN scan ports 1-1024 from 10.251.96.4

### 3.2 Web Enumeration
- Directories bruteforce, gobuster 3.0.1, found editprofile.php

### 3.3 SQL Injection Attempt
- sqlmap 1.4.7

### 3.4 Web Shell Upload
- POST to editprofile.php 
- uploaded web shell dbfunctions.php from file upload vulnerability

### 3.5 Command Execution
- GET/uploads/dbfunctions.php?cmd=id - first command from web shell

### 3.6 Reverse Shell
- Reverse shell to port 4422 from python socket

## 4. Answers Summary
| Question | Answer |
|----------|--------|
| What is the IP responsible for conducting the port scan activity? | 10.251.96.4 |
| What is the port range scanned by the suspicious host? | 1-1024 |
| What is the type of port scan conducted? | TCP SYN|
| Two more tools were used to perform reconnaissance against open ports, what were they? | Gobuster 3.0.1, sqlmap 1.4.7 |
| What is the name of the php file through which the attacker uploaded a web shell? | editprofile.php |
| What is the name of the web shell that the attacker uploaded? | dbfunctions.php |
| What is the parameter used in the web shell for executing commands? | cmd |
| What is the first command executed by the attacker? | id |
| What is the type of shell connection the attacker obtains through command execution? | reverse |
| What is the port he uses for the shell connection? | 4422 |

## 5. Mitigation

Port scan - IDS/IPS alert on SYN scan, network segmentation
Directory bruteforce - rate limiting, WAF block by User-Agent
SQL injection - WAF, prepared statements (parameterized queries)
File upload - validate file extension and MIME type server-side, block .php uploads
Command execution - web shell would not execute if step 4 is implemented correctly; monitor anomalous processes via EDR
Reverse shell - egress filtering, block outbound connections from web server to non-standard ports
