# Week 2 - Networking Advanced

## Key Insights
1. Brute force of vpn packets (in the road from dot A to dot B) is unreal, so hackers can try obvilous ways to get info from packets like:
Get access to dot A
Get access to dot B (VPN server is poisoned)
DNS spoofing
2. When i used wireshark in http site (for testing) i saw that we can see all of the information and if we can to entry password or other private data, it will be seem on wireshark
3. Each hop in tracert is one router. Saw 13 hops from my device through Kyivstar network to Google datacenter in Berlin

## Tools Used
- Wireshark - captured HTTP traffic, saw GET request in plaintext
- wf.msc - created and deleted firewall rule for port 80
- tracert - traced route to google.com, 13 hops through Kyivstar to Berlin

## What I Learned About SOC Work
1. Really used in SOC is : firewall + rules + ports - which we close and when, which we open and when
2. Setting up VPN/remote access/IpSec connection for - man to company, remote access, company office to company office, but need to understand that these methods is bypassing firewall defence and get access to company network
3. Using Wireshark to collect and analyzing data, anomaly events
