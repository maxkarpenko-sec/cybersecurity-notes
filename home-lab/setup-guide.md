# Home Lab Setup Guide

## Lab Architecture

**Goal:** Build an isolated attack/defense environment to simulate real SOC scenarios.

**Machines:**
- Kali Linux 2025.4 - attacker machine
- Ubuntu Server 24.04.4 LTS - target + SIEM server (Wazuh)

**Network:** VirtualBox Host-Only 192.168.56.0/24 - isolated network for attacks, no traffic leaves to external network.

## Setup Process

### ISO Downloads
- `ubuntu-24.04.4-live-server-amd64.iso`
- `kali-linux-2025.4-virtualbox-amd64.iso`

### VirtualBox Network Configuration

Ubuntu VM - two adapters:
- Adapter 1: Host-Only (192.168.56.102) - attack surface, communication with Kali
- Adapter 2: NAT - internet access for downloading packages

Kali VM - two adapters:
- Adapter 1: NAT - internet access
- Adapter 2: Host-Only (192.168.56.103) - attack network

### Troubleshooting

Copy-paste doesn't work in VirtualBox console directly. Solution - connect to Ubuntu via SSH from Windows PowerShell:
```bash
ssh wazuh@192.168.56.102
```

This is the standard workflow in real SOC environments - analysts always SSH to servers rather than working in console directly.

## Final Network Map
```
[Kali 192.168.56.103] ----attack----> [Ubuntu 192.168.56.102]
                                              |
                                        Wazuh SIEM
                                        Apache2
                                        OpenSSH
                                        Cowrie Honeypot :2222
```
