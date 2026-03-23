# Wazuh SIEM Installation and Configuration

## What is Wazuh

Wazuh is an open source SIEM/XDR platform used in real SOC environments.
Three components:
- Manager - processes and analyzes alerts
- Indexer - stores data (based on OpenSearch)
- Dashboard - web interface for alert visualization

## Installation

Installed via official script on Ubuntu 24.04:
```bash
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh && sudo bash wazuh-install.sh -a -i
```

Installation time: ~15 minutes. Script automatically configures all three components.

**Version:** Wazuh 4.9.2

**Dashboard access:** https://192.168.56.102
<img width="960" height="861" alt="image" src="https://github.com/user-attachments/assets/30818760-b0d4-4d36-86be-3f1b8bfeb628" />

## Agent Deployment

Deployed Wazuh agent on Kali Linux (attacker machine) to monitor it:
```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.9.2-1_amd64.deb
sudo WAZUH_MANAGER='192.168.56.102' dpkg -i wazuh-agent_4.9.2-1_amd64.deb
sudo systemctl enable wazuh-agent && sudo systemctl start wazuh-agent
```

**Result:** 1 active agent (Kali) connected to Wazuh Manager.

## Active Response Configuration

Configured automatic IP blocking after brute force detection.
Added to `/var/ossec/etc/ossec.conf`:
```xml
<active-response>
  <command>firewall-drop</command>
  <location>local</location>
  <rules_id>5763</rules_id>
  <timeout>180</timeout>
</active-response>
```
<img width="1512" height="801" alt="image" src="https://github.com/user-attachments/assets/b316960e-00ec-458f-8810-22758d357423" />

When rule 5763 fires (SSH brute force detected) - Wazuh automatically blocks the attacker IP via iptables for 180 seconds.
