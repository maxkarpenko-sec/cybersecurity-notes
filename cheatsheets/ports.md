# HTTP/HTTPS + Ports

## 1. Ports

| Port | Protocol | What's doing | CS risks |
|------|----------|-------------|----------|
| 21 | ftp | file transfer | password is unencrypted |
| 22 | ssh | remote access (safe) | brute force attacks |
| 23 | telnet | remote access (old) | everything in plaintext |
| 25 | smtp | sending mails | email spoofing, spam |
| 53 | dns | translates names in ip | tunneling, ddos |
| 80 | http | web without encryption | sqli, xss |
| 443 | https | web with encryption | checking certificates |
| 445 | smb | common folders windows | eternalblue (wanna cry) |
| 3306 | mysql | database | sqli if exposed externally |
| 3389 | rdp | remote desktop | bruteforce, bluekeep |

## 2. HTTP

Methods:
- Get - get data
- Post - send data
- Put - update
- Delete - delete

Reply codes:
- 200 - OK (all good)
- 301 - Redirect (redirection)
- 400 - Bad request (invalid request)
- 401 - Unauthorized (is not authorized)
- 403 - Forbidden (has no rights)
- 404 - Not found
- 500 - Server error (server is broken)

HTTPS = HTTP + TLS encryption
Without HTTPS passwords transmitted in plaintext

## My observations

- netstat -anb showed port 445(SMB) opened in my pc
- All browser connections going to port 443 (HTTPS)
- Google using port 5228 for push notifications
- Upon opening google.com browser made 34 requests
- First request: Get, status 200 OK, to IP 142.250.130.139:443
