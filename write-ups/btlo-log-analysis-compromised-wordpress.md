# BTLO - Log Analysis: Compromised WordPress

## 1. Overview
- Platform: blueteamlabs.online
- Date: 19.03.2026
- Scenario: One of our WordPress sites has been compromised but we're currently unsure how. The primary hypothesis is that an installed plugin was vulnerable to a remote code execution vulnerability which gave an attacker access to the underlying operating system of the server.

## 2. Tools Used
- Notepad++ (Ctrl+F search across 500,000+ character log file)

## 3. Analysis

### 3.1 Initial Triage
The provided file is an Apache access log. Initial search focused on `/wp-login.php` and `/wp-admin` to identify authentication activity and admin panel access attempts.

### 3.2 Attacker Identification
Three suspicious IPs were identified:
- `119.241.22.121` - used WPScan v3.8.10 and python-requests/2.24.0, performed brute force login attempts
- `103.69.55.212` - fingerprinted plugins via readme.txt, exploited Contact Form 7, executed web shell commands
- `168.22.54.119` - used sqlmap/1.4.11, performed brute force login attempts

### 3.3 Reconnaissance
`119.241.22.121` scanned the site using WPScan v3.8.10 to enumerate plugins and vulnerabilities. `103.69.55.212` manually browsed to `/wp-content/plugins/simple-file-list/readme.txt` to identify the plugin version. The attacker also attempted to exploit Contact Form 7 (ver 5.3.1, CVE-2020-35489) by uploading files through the contact form endpoint.

### 3.4 Web Shell Upload
`119.241.22.121` uploaded `fr34k.png` via the Simple File List plugin upload endpoint (`ee-upload-engine.php`). The file was then renamed to `fr34k.php` using `ee-file-engine.php`, bypassing the file extension check. The web shell was placed at `/wp-content/uploads/simple-file-list/fr34k.php`.

### 3.5 Post-Exploitation
`103.69.55.212` accessed and executed commands via `fr34k.php` through multiple GET and POST requests. The final request to the web shell returned HTTP 404 — the shell was deleted or self-destructed after use.

## 4. Answers Summary

| Question | Answer |
|----------|--------|
| URI of the admin login panel (include token) | /wp-login.php?itsec-hb-token=adminlogin |
| Two tools the attacker used | WPScan sqlmap |
| CVE for Contact Form 7 vulnerability | CVE-2020-35489 |
| Plugin exploited to get access | Simple File List 4.2.2 |
| PHP web shell file name | fr34k.php |
| HTTP response code on final web shell access | 404 |

## 5. Mitigation

1. **File upload validation** - validate file extension and MIME type server-side; block PHP file uploads entirely
2. **Plugin updates** - keep all WordPress plugins updated; Simple File List 4.2.2 and Contact Form 7 5.3.1 were both vulnerable
3. **Admin panel protection** - iThemes Security token helped obscure the login page but was still discovered; combine with 2FA and IP allowlisting
4. **WAF rules** - block requests from known scanning tools (WPScan, sqlmap) by User-Agent at WAF/proxy level
5. **Web shell detection** - monitor `/wp-content/uploads/` for PHP file creation via EDR or file integrity monitoring
6. **Log monitoring** - SIEM rule to alert on multiple failed POST requests to wp-login.php from the same IP within a short time window
