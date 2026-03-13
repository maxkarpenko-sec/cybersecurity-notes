# Nessus Home Network Scan Report

**Date:** 2026-03-13
**Tool:** Nessus Essentials
**Scanner:** Local Scanner
**Policy:** Basic Network Scan
**Target:** 192.168.x.x/24
**Duration:** 16 minutes

---

## Executive Summary

Used Nessus Essentials (free version, limit 16 IP) to scan active devices in home network.
First, discovered active hosts via Nmap in Kali Linux:
```
sudo nmap -sn 192.168.1.0/24
sudo nmap -sV -O -p- <5 IPs>
```

Found 5 active devices. Ran parallel Nessus Basic Network Scan against the same 5 IPs.
Total vulnerabilities found: 40 across all hosts. Main findings on router 192.168.x.1.

---

## Hosts Discovered

| Host | Device | OS | Vulnerabilities |
|------|--------|----|----------------|
| 192.168.x.1 | Router TP-LINK | Unknown | 2 Critical, 4 High, 9 Medium |
| 192.168.x.100 | Unknown | Unknown | 1 Low |
| 192.168.x.101 | Unknown | Unknown | 63 Info |
| 192.168.x.102 | Windows Host (Gigabyte) | Windows 11 | 10 Info |
| 192.168.x.103 | Kali Linux | Linux | 3 Info |

---

## Key Findings

### Finding 1 - SuperMicro IPMI PSBlock (CVSS 9.8) - FALSE POSITIVE
**Severity:** Critical
**Plugin ID:** 76213
**Port:** 1900/tcp

Nessus plugin 76213 triggered on port 1900 (UPnP) and interpreted the UPnP response
as a SuperMicro IPMI PSBlock file. The actual device is a TP-LINK router, not a
SuperMicro server with an IPMI controller. Nessus incorrectly identified the OS.
This is a false positive caused by inaccurate device fingerprinting.

---

### Finding 2 - OpenSSH Multiple Vulnerabilities
**Severity:** Critical/High
**Affected host:** 192.168.x.1
**SSH Version detected:** OpenSSH 6.6.0 (2014)

Router runs an SSH daemon that has not been updated since 2014. This allows potential
remote code execution via X11 forwarding and multiple other attack vectors on an
unpatched SSH service.

**CVEs:**
- OpenSSH < 7.2 Untrusted X11 - CVSS 9.8
- OpenSSH < 6.9 Multiple Vulnerabilities - CVSS 8.5
- OpenSSH 5.4 < 7.1p2 - CVSS 8.1
- OpenSSH < 7.4 - CVSS 7.8
- OpenSSH < 7.3 - CVSS 7.8

---

## Recommendations

| Finding | Action | Priority |
|---------|--------|----------|
| OpenSSH 6.6.0 on router | Update router firmware or disable SSH if not needed | High |
| UPnP open | Disable if no smart devices require it | Medium |
| HTTP without HTTPS on router | Enable HTTPS on admin panel if supported | Medium |

---

## Lessons Learned

Not all alerts represent real problems - many are false positives. Identifying whether
an alert is true positive, false positive, or false negative requires understanding
the infrastructure being defended.

Without knowing the actual devices, services, and configurations in the environment,
the false positive rate increases significantly. In SOC work, reducing false positives
is critical - unnecessary escalations waste analyst time and create alert fatigue.

---

## Tools Used

- Nmap 7.95 - host discovery and port scanning
- Nessus Essentials - vulnerability scanning
