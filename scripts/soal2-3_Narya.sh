#!/bin/bash

IP_VILYA="192.236.1.194"

# 1. ALLOW akses DNS (TCP/UDP) dari Vilya
iptables -A INPUT -p udp --dport 53 -s $IP_VILYA -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -s $IP_VILYA -j ACCEPT

# 2. DROP akses DNS (TCP/UDP) dari IP lain
iptables -A INPUT -p udp --dport 53 -j DROP
iptables -A INPUT -p tcp --dport 53 -j DROP

# 3. Verifikasi Rule
echo "Aturan Isolasi DNS diterapkan."
iptables -L INPUT -n | grep "dpt:53"

# 4. Jalankan Service
service named restart