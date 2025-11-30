#!/bin/bash

# === MISI 2.4: WEEKEND ACCESS ===
IP_ALLOWED="192.236.0.0/24,192.236.1.128/26" # Gabungan Subnet Manusia & Kurcaci

# Allow Weekend & Authorized IP
iptables -A INPUT -p tcp --dport 80 -s $IP_ALLOWED -m time --weekdays Sat,Sun -j ACCEPT
# Drop sisa akses web
iptables -A INPUT -p tcp --dport 80 -j DROP
echo "Misi 2.4 Applied: Weekend Access Only"