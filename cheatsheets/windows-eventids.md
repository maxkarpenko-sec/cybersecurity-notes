# Windows Event IDs

## key event ids
4624 - succesful login - who, when, from where was entry
4625 - unsucceful login - 50+ times per minute=bruteforce
4672 - special previlege - who get admin rights
4688 - new process is runned - seen malvare there
4720 - new user was created - backdoor account
1102 - journal was cleared - attacker cover up traces
7045 - new service was installed - malware persistence

## logon types
2 - physical (on machine)
3 - network
10 - RDP

## error codes (4625)
0xc000006a - wrong password
0xc0000064 - user is not exists
0xc0000234 - account was blocked

## powershell commands for soc
Get-EventLog -LogName Security -InstanceId 4625 -Newest 10
Get-NetTCPConnection | Where-Object {$_.State -eq "Established"}
Get-Process | Select-Object Name, Id, CPU, Path | Sort-Object CPU -Descending
Get-LocalGroupMember -Group "Administrators"
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

## red flags
Word -- PowerShell (Macro virus)
Process from AppData/Temp
Two different MAC's in one IP (ARP spoofing)

## kerberos
TGT - master ticket (after password entry)
Service Ticket - ticket to specific resourse
Golden Ticket - attacker writes TGT himself
Treatment - change password from account **krbtgt** twice (to invalidate all TGTs)
