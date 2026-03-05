# Week 3 - ARP, Wireshark, Nmap

## ARP
IP to MAC in local network
## ARP Spoofing
Man on the middle, if hacker have access to local network, he can send forbidden arp responses - all traficc going thouth him. In arp -a - one IP and 2 MACs address - may be man on the middle 
## Wireshark filters (top 5 which i used)
http.request.method == "POST"
dns.qry.name contains "evil"
arp
ip.src == X && tcp.port == 80
tcp.port == 4444
## Nmap - what i learned
Firstly how to check what devices in my network throuth cmd, powershell, linux: arp -a
Secondly how hackers can get passwords, logins when they have access to network and we using http (saw plaintext in wireshark)
How to use Nmap, how to see what device is and what weak place have
## Lab results
Analyzed network, and found that ports 80, 1900, 22 is opened. Gived danger status (high,medium) and advices how to protect network and when
