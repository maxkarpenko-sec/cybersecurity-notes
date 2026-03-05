# Home Network Security Audit

## Target
- Date: 03.03.2026
- Network: 192.168.1.0/24
- Tools used: nmap, wireshark

## Reconnaissance
┌──(kali㉿kali)-[~]
└─$ nmap -sV 192.168.1.1
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 6.6.0 (protocol 2.0)
80/tcp   open  http    TP-LINK router http config
1900/tcp open  upnp    TP-LINK router upnpd
MAC Address: XX:XX:XX:XX:XX:XX (Mercusys/TP-LINK)

## Findings

### Finding 1 — OpenSSH 6.6.0
- Port: 22/tcp
- Risk: high
- Description: very old software version (10+years)
- Recommendation: update software

### Finding 2 — HTTP Admin Panel
- Port: 80/tcp
- Risk: medium
- Description: password and login to admin panel (192.168.1.1) in plaintext
- Recommendation: Set Https, if cannot - in network may be only registered devices

### Finding 3 — UPnP
- Port: 1900/tcp
- Risk: medium
- Description: no authentification (mirai botnet 2016)
- Recommendation: close UPnP in routher settings if not used actively

## Summary
3 security issues found on Mercusys router
Main risks: outdated SSH version with known CVEs, unencrypted admin panel, UPnP enabled
Recommended actions: update firmware, enable HTTPS, disable UPnP
