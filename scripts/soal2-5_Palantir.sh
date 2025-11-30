#!/bin/bash

# === MISI 2.5: SHIFT KERJA ===
IP_ELF="192.236.1.0/25"
IP_MANUSIA="192.236.0.0/24"

# Rule Elf
iptables -A INPUT -p tcp --dport 80 -s $IP_ELF -m time --timestart 07:00 --timestop 15:00 -j ACCEPT
# Rule Manusia
iptables -A INPUT -p tcp --dport 80 -s $IP_MANUSIA -m time --timestart 17:00 --timestop 23:00 -j ACCEPT
# Drop sisa web
iptables -A INPUT -p tcp --dport 80 -j DROP

echo "Misi 2.5 Applied: Shift Kerja"
