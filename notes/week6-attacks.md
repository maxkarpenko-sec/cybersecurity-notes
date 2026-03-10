# Week 6 - Attacks: Malware, Phishing, Social Engineering

## What i learned

### Malware types
virus
worm
trojan
ransomware
spyware
rootkit
backdoor
botnet

### Kill Chain
Recon - Osint, search of weak places
Weaponize - creating malware
Delivery - malvare delivery for example ethernalblue throught port 445
Exploit - start scripts
Installing - malware installing
C2 - connect to control main server
Act - data encryption, collection data

### CIA Triad
C - Confidentiality
I - Integrity  
A - Availability

### Social Engineering

phishing
spear phishing
whaling
vishing
smishing
baiting

### Network attacks
DDoS
Dns Poisoning
Replay attack
Lateral Movement
## Tools used
Virustotal, PhishTank, AttackMitre

## Lab results
Went to PhishTank to take some links and do own researches. I used 2 link, first - pepsico.live (PHISHING SITE), but original is - pepsico.com. Looks like very original and virus total outputed 0 detection because click to link is safe but they collect data that you enty
Second link - moneyswift.munya.co.zw, looks some weird but also as pepsico.live collects your data and also have 0 detection in virus total. That's all becouse bases from virustotal and phishtank not syncronyzed
My conclusion is - never open links, never doing things, never dowload files from mails, I must have a alghorytm that was fast and secure :
1. virustotal - scanning URL, files, hashes
2. PhishTank - phishing site base
3. AbuseIPDB - IP reputation
4. Whois - domain information

## Key takeaways
1. VirusTotal 0/95 = safe - phishing works without malware in URL
2. Different security tools have different databases - always use multiple
3. MITRE ATT&CK connects theory to practice - T1547 is exactly what 
   i checked via PowerShell (Registry Run Keys)
4. Phishing detection requires context - domain age, password-input tags, 
   sender address - not just antivirus scan
5. Social engineering targets humans, not systems - technical tools won't 
   always catch it
