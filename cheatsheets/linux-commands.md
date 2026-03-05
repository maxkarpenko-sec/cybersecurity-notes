# Linux Commands

## navigation
ls -la
cd 
pwd
cd /path
cd ..
cd ~
## files
cat
file
head -n 20 file
tail -n 20 file
touch file
mkdir dir
rm file
cp a b
mv a b
## search
find / -name "*.conf"
find / -perm -4000 2>/dev/null
grep "error" /var/log/syslog
grep -r "text" /etc/
## permissions
chmod 755 file
chown user:group file
## processes
ps aux
ps auxf
kill PID
## network
ss -tulnp
ip a
## logs
journalctl -n 20
journalctl -p err -n 10
journalctl -f
journalctl _SYSTEMD_UNIT=ssh.service
## cron
crontab -l
crontab -e
crontab -r
