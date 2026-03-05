# Week 4 - Linux

## What i learned

Started with basic navigation - pwd, ls -la, cd, cat, head, tail, touch, mkdir, rm, cp, mv. Spent time in /etc directory, got used to reading file structure

Learned how to read permissions from ls -la output - owner, group, others, rwx bits. Practiced chmod 755 and chown. Found all SUID files on system with find / -perm -4000, learned why pkexec is dangerous (CVE-2021-4034, was in linux 12 years unnoticed)

Processes - ps aux shows everything running, ps auxf shows parent-child tree. Key insight: if bash spawned netcat - thats a red flag for reverse shell. Started python3 http server in background with &, then saw it in ss -tulnp output. Thats exactly how C2 server looks from inside victim machine

Logs - Kali uses journalctl instead of syslog. Simulated SSH brute force on localhost, found failed password entries in journal, extracted attacker IPs with awk one-liner. This is real L1 SOC task

Cron - added task to crontab, confirmed network-scanner.sh runs every minute and writes results to scan.log. Attackers use cron for persistence - reverse shell that survives reboot

Wrote my first bash script - network-scanner.sh. Loop through 192.168.1.1-254, ping each host, print alive ones. Ran it via cron

Completed OverTheWire Bandit levels 0-5.

## Lab results
- mapped full home network 192.168.1.0/24
- confirmed python3 process visible in ss output
- caught failed SSH logins in journalctl, extracted IPs
- network-scanner.sh running via cron, output to scan.log
- found SUID files including pkexec CVE-2021-4034
