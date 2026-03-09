# Week 5 - Windows Security

## What i learned

Started with Event Viewer - learned key Event IDs that SOC analysts monitor daily
Practiced finding real events on my Windows 11 machine

Learned PowerShell for security analysis - checked running processes with paths,
active network connections, services, registry autorun and local administrators

Checked all active connections with Get-NetTCPConnection, verified suspicious IPs
on AbuseIPDB. All connections were legitimate (Google, Microsoft, Akamai, Datagroup UA)

Covered Active Directory basics - Domain, DC, OU, GPO. Learned Kerberos authentication
flow - TGT, Service Ticket, Golden Ticket Attack

## Lab results
- Found Event ID 4624, 4625, 4688 in real Event Viewer
- Analyzed failed login attempt - wrong password from localhost (me)
- Checked all running processes, found no suspicious paths
- Verified 7 active connections via AbuseIPDB - all clean
- Checked registry autorun - OneDrive, Steam, Discord (all legitimate)
- Confirmed 2 local admins: Administrator + Max

## Key takeaways
- Logon Type 10 at night from unknown IP = immediate alert
- Process path matters more than process name
- 1102 = logs cleared = someone was hiding something
- Golden Ticket = change krbtgt password twice
