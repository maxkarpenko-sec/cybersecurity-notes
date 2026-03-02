# Wireshark Filters

## Investigation Algorithm

1. dhcp - find victim IP and gateway
2. dns.flags.response == 0 - see what domains the machine is querying
3. ip.dst != 10.x.x.0/24 - find all outbound traffic to external IPs
4. http.request - see all HTTP requests
5. Follow HTTP Stream - read full session content

<img width="1919" height="1014" alt="image" src="https://github.com/user-attachments/assets/ab1ec979-8018-4813-8179-2ebc3e3a6062" />

---

## Network Recon

dhcp - shows DHCP handshake, reveals victim IP and gateway
arp - shows who is in the network, used to detect ARP Spoofing
arp.duplicate-address-detected - duplicate IP detected, sign of ARP Spoofing attack

---

## DNS

dns.flags.response == 0 - only DNS queries, shows what domains the machine is trying to resolve
dns.flags.response == 1 - only DNS responses, shows real IPs domains resolve to. In this sample: EASYAS123-DC.easyas123.tech resolved to 10.2.28.2 (domain controller)
dns.qry.name contains "word" - filter by keyword in domain name, used to track suspicious domains like easyas123.tech
dns.qry.name matches "[a-z]{15,}" - long random domain names, sign of DGA (malware auto-generating C2 domains)

---

## HTTP

http.request - all HTTP requests
http.request.method == "POST" - data being sent to server. In this sample: victim 10.2.28.88 sending repeated POSTs to 45.131.214.85/fakeurl.htm every ~60 seconds - C2 beaconing
http.request.method == "GET" - not observed in this sample
http.host contains "word" - not observed in this sample
http contains "password" - not observed in this sample
http.response.code == 200 - successful server response. In this sample: C2 server at 45.131.214.85 responding 200 OK to every beacon
http.response.code == 404 - not observed in this sample

---

## Suspicious Traffic

ip.dst != 10.0.0.0/8 && ip.src == [victim IP] - all outbound traffic from host to external IPs. In this sample: revealed beaconing to 45.131.214.85
tcp.port == 4444 - default Metasploit reverse shell port
tcp.port == 1337 - non-standard port commonly used in C2 communications
frame.len > 1400 - large packets, possible data exfiltration
tcp.flags.syn == 1 && tcp.flags.ack == 0 - SYN packets without ACK response, pattern of port scanning (Nmap -sS)

---

## Combinations

ip.src == 192.168.1.10 && tcp.port == 80 - analyze all traffic from specific host on port 80
dns && ip.src == [victim IP] - all DNS activity from compromised machine
http.request && ip.dst != 10.0.0.0/8 - HTTP requests going outside the network
tcp.analysis.retransmission - retransmitted packets, connection instability or C2 trying to reach back. In this sample: seen on port 443, malware attempting HTTPS fallback to C2

---

## Real Case - 2026-02-28

Victim: 10.2.28.88 (Intel, Windows)
C2: 45.131.214.85
Endpoint: /fakeurl.htm
Malware: NetSupport Manager RAT
Pattern: CMD=POLL (keepalive) + CMD=ENCD DATA= (encrypted exfiltration)
Detection: repeated POST to external IP, non-standard User-Agent, fixed interval beaconing
