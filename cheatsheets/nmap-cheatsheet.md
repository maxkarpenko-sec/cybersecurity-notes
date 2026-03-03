# nmap cheatsheet

## scan types

TCP Connect (-sT) - full 3-way handshake without root
SYN Scan (-sS) - SYN -> SYN-ACK -> RST (no ending) fast, silent, need root
UDP Scan (-sU) - slow, unreliable, when needs UDP
Ping Scan (-sn) - only live hosts, without ports, inventarization
Version Detection (-sV) - service banners, whats turned on
OS Detection (-O) - TTL+TCP fingerprint - victims OS
Aggressive (-A) - -sV -O --traceroute + scripts, all in

---

## port states

open - port listening, service working
closed - port reply RST, no service
filtered - firewall blocking, no reply
open|filtered - unable to determine (UDP often)
filtered vs closed difference - filtered not shown (no-response), closed also not shown (reset), both in ignored states

---

## useful flags

-p - specific ports
-p- - all of 65535 ports
-T4 - speed (T4 fast)
-oN - oN file.txt to save results
-oX - oX file.xml XML for SIEM
--top-ports - top N ports in frequency

---

## nse scripts

--script=vuln - common vulnerabilities
--script=http-title - grabs webpage title
--script=smb-vuln-ms17-010 - EternalBlue check
--script=ftp-anon - anonymous FTP check

---

## my home network scan (date: 2026-03-03)

subnet: 192.168.1.0/24
kali ip: 192.168.1.102

192.168.1.1 - router
  open ports: 22/tcp ssh, 80/tcp http, 1900/tcp upnp

192.168.1.100 - may be smartphone or smart device - 1000 ports closed (reset) live but not listening
192.168.1.101 - my windows, 1000 ports filtered, windows firewall cuts all - no response because of this
192.168.1.102 - Kali, kali replies RST, no services up

suspicious findings:
Router - OpenSSH 6.6.0 thats 2014, very old version, in 10+ years in this version found some CVE, outdated software on network device
Port 80 HTTP - admin panel of router without encryption, so login-password in plaintext like i saw in wireshark when tested http
UPnP on 1900 - protocol that gives permission for devices to automatically open ports in router. Used in real cases (Mirai botnet 2016 - 600.000 devices were infected, partly through UPnP)

---

## notes for soc

1. Router TP-Link with old SSH
2. Admin panel over HTTP (not HTTPS)
3. UPnP on - potential point of entry
