# Week 8 - SOC, SIEM, Splunk, Incident Response

## What i learned

### SIEM
Monitoring system that collects logs from all systems in one place. 
Without SIEM it's impossible to manually monitor emails, Windows events, 
firewalls across 1000+ machines simultaneously. SIEM acts as a central 
hub that correlates events and creates alerts automatically.
Popular: Splunk, QRadar, Microsoft Sentinel

### IOC types
IP address - checked via AbuseIPDB
Hash - checked via VirusTotal
Domain - checked via VirusTotal + PhishTank
Email sender - phishing analysis
URL - checked via VirusTotal + PhishTank

### SPL queries
index=main EventCode=4625 - all failed logins
index=main EventCode=4625 | stats count by src_ip | sort -count | head 10 - top IPs brute force
index=main EventCode=4624 LogonType=10 - all RDP logins

### Incident Response (NIST)
1. Preparation - SIEM configured, backups ready, playbooks exist
2. Identification - is this an incident? SOC L1 analyzes alert in SIEM
3. Containment - isolate machine, stop spreading. SOC L1 zone
4. Eradication - remove malware, close entry vector. L2/L3
5. Recovery - restore from backup, verify integrity. L2/L3
6. Lessons Learned - report, what to improve. L2/L3

SOC L1 responsibility: steps 2 and 3 only

### Pyramid of Pain
Hash - bottom, attacker changes in seconds by recompiling malware
IP - changes in minutes, easy to replace
TTPs - top, attacker's methodology. Expensive and slow to change
SOC goal: detect behavior (TTPs) not just block indicators
Blocking IP is a bandaid. Detecting TTP is the cure

## Tools used
Splunk, VirusTotal, AbuseIPDB, PhishTank

## Lab results
Completed Splunk Intro to Splunk eLearning course - scored 86% on quiz
Certificate obtained and added to LinkedIn
Learned SPL basics - pipe operator, stats, sort, filtering by EventCode
Verified IOCs using AbuseIPDB and VirusTotal during previous weeks practice

## Key takeaways
1. SIEM is the central tool of SOC - without it monitoring is impossible at scale
2. IOC checking requires multiple tools - VirusTotal 0/72 does not mean clean
3. SOC L1 job is identification and containment - detect fast, isolate faster
