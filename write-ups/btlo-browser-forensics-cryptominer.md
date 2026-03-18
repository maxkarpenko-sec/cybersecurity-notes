# BTLO - Browser Forensics: Cryptominer

## 1. Overview
Scenario
Our SOC alerted that there is some traffic related to crypto mining from a PC that was just joined to the network. The incident response team acted immediately, observed that the traffic is originating from browser applications. After collecting all key browser data using FTK Imager, it is your job to use the ad1 file to investigate the crypto mining activity.

## 2. Tools Used
FTK Imager

## 3. Analysis
I have browser dump, so start with this. Open .ad1 file and read README in archive with dump, in FTK seen folder catalogs and start working with questions

### 3.1 Evidence Loading
Loaded browserdata.ad1 in FTK Imager via File -- Add Evidence Item -- Image File. Navigated to Users/IEUser/AppData/Local/Google/Chrome/User Data

### 3.2 Chrome Profiles
We have 2 profiles

### 3.3 Browser Theme
Earth in Space installed in chrome

### 3.4 Cryptominer Extension
egnfmleidkolminhjlkaomjefheafbbb, DFP Cryptocurrency Miner

### 3.5 Miner Configuration
20 hashes per second, public key - b23efb4650150d5bc5b2de6f05267272cada06d985a0

## 4. Answers Summary

How many browser-profiles are present in Google Chrome? 
2
What is the name of the browser theme installed on Google Chrome? 
Earth in Space
Identify the Extension ID and Extension Name of the cryptominer 
egnfmleidkolminhjlkaomjefheafbbb, DFP Cryptocurrency Miner
What is the description text of this extension? 
Allows staff members to mine cryptocurrency in the background of their web browser
What is the name of the specific javascript web miner used in the browser extension? 
cryptoloot
How many hashes is the crypto miner calculating per second? 
20
What is the public key associated with this mining activity? 
b23efb4650150d5bc5b2de6f05267272cada06d985a0
What is the URL of the official Twitter page of the javascript web miner? 
twitter.com/CryptoLootMiner


## 5. Mitigation
1. SIEM alert on crypto mining traffic — isolate machine
2. Check all installed browser extensions on corporate machines via policy
3. Block known mining domains (crypto-loot.com) on proxy/firewall
4. Implement browser extension whitelist via Group Policy
5. Monitor outbound traffic to mining pools
