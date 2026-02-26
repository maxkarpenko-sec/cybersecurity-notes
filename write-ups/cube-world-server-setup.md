# Local Game Server Setup & Network Diagnostics - Windows 11

## Task
Two laptops on the same Wi-Fi network. Goal: run a local game server on one and connect from the other. Had to diagnose and fix several network issues in the process

## Environment
- Host (server): Windows 11, IP - 192.168.0.107
- Client: Windows 10, IP - 192.168.0.106
- Router
- Game: CubeWorld 0.1.1

## Problem
- ping 192.168.0.107 - "The specified host is not reachable"
- ping 192.168.0.106 - "Timeout for request exceeded"

## Step 1 - Find IP addresses
Command: ipconfig
What it does: shows ipv4 and other network info
What I learned: how to get network info for device

## Step 2 - Check connection between laptops
Command: ping IP
Problem I found: devices cannot even ping each other
Why it happened: Firewall rules, windows 11 basic rules, network type (windows 11 wifi connection setted as public domain windows 10 setted as private)
What is ICMP: Network diagnosting protocol, ping working throuth him. If ICMP blocked by firewall, we can't even ping each other even in one network

## Step 3 - Network type change
Command: Set-NetConnectionProfile -NetworkCategory Private
Why it matters: change from public domain to private wifi connection

## Step 4 - Allow ICMP through firewall
Command: netsh advfirewall firewall add rule name="ICMP Allow" protocol=icmpv4:8,any dir=in action=allow
What it does: Set firewall rule for current Ipv4 connection, in occasion we have access to connect to eachother

## Step 5 - Check real port
Command: netstat -an | findstr LISTENING
What I found: server config said port 26879 but netstat showed real port was 12345 - game ignored config file.
Key lesson: Always verify real port with netstat - don't trust config files alone

## Step 6 - Open ports in firewall
Commands: 
For .exe server
New-NetFirewallRule -DisplayName "Server.exe Inbound" -Direction Inbound -Program "C:\Users\Макс\Desktop\CubeWorld\Server.exe" -Action Allow

For.exe client
New-NetFirewallRule -DisplayName "Cube.exe Inbound" -Direction Inbound -Program "C:\Users\Макс\Desktop\CubeWorld\Cube.exe" -Action Allow

Or for ports: 
New-NetFirewallRule -DisplayName "Cube World TCP" -Direction Inbound -Protocol TCP -LocalPort 12345 -Action Allow

New-NetFirewallRule -DisplayName "Cube World UDP" -Direction Inbound -Protocol UDP -LocalPort 12345 -Action Allow

Why both TCP and UDP: TCP for reliable connection, UDP for fast real-time data (game state, movement). Game servers often use both

## Step 7 - Static IP
Command: netsh interface ip set address "Wi-Fi" static 192.168.0.200 255.255.255.0 192.168.0.1
Why static not dynamic: because for dynamic we need adding rules after reconnection or router restart, for static IP only once but we need to set static IP for example .200 (not .107 .105) because DHCP pool typically assigns .100-.150, so .200 avoids IP conflicts 

## Key Takeaways
1. Windows 11 and windows 10 like other OS have different basic rules setted to ethernet connections + ports opened/closed
2. In some cases static IP can be usefull
3. Need to check what ports is secure to open and when, which no
4. Always verify real port with netstat - don't trust config files alone
