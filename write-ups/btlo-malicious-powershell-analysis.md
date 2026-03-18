# BTLO - Malicious PowerShell Analysis

## 1. Overview
Scenario
Recently the networks of a large company named GothamLegend were compromised after an employee opened a phishing email containing malware. The damage caused was critical and resulted in business-wide disruption. GothamLegend had to reach out to a third-party incident response team to assist with the investigation. You are a member of the IR team - all you have is an encoded Powershell script. Can you decode it and identify what malware is responsible for this attack?

## 2. Tools Used
- CyberChef
- VirusTotal

## 3. Analysis
I have powershell file (ps script), but it was encoded. Standart encode for Powershell is BASE64 with decode UTF-16LE(1200)

### 3.1 Initial Triage
We have txt file that contains:
POwersheLL  -w hidden -ENCOD                 IABzAEUAdAAgAE0ASwB1ACAAKAAgAFs...

### 3.2 Decoding
<img width="1919" height="867" alt="image" src="https://github.com/user-attachments/assets/2b2c2a88-887e-4f60-8a83-bf8328ed6334" />


### 3.3 Script Analysis
Standart attempt to circumvent antivirus defence, because it complyle not full file or link, it's: a+a+12+dll for example, not aa12.dll full
Also script is trying to trick us because used not only one Url
1. Creates the directory \HOME\Db_bh30\Yf5be5g\
2. Sets the TLS 1.2 protocol
3. Downloads A69S.dll from 6 different URLs
4. Runs it via rundll32 with the Control_RunDLL parameter

### 3.4 Malware Identification
Emotet

## 4. Answers Summary
| Question | Answer |
|----------|--------|
| Security protocol | TLS1.2 |
| Directory created | \HOME\Db_bh30\Yf5be5g |
| File downloaded | A69S.dll |
| Execution method | rundll32 |
| Domain /6F2gd/ | wm.mcdevelop.net |
| Malware name | Emotet |

## 5. Mitigation
1. Block identified domains on firewall
2. Disable PowerShell for regular users via Group Policy
3. Enable PowerShell Script Block Logging
4. Email gateway — block phishing attachments
5. EDR alert on rundll32 loading unknown DLLs
