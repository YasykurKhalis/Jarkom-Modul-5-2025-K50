#!/bin/bash
IP_VILYA="192.236.1.194"

echo "Menghapus aturan-aturan Iptables untuk isolasi DNS..."
# --- 1. Hapus aturan DROP akses DNS (TCP/UDP) dari IP lain ---
iptables -D INPUT -p udp --dport 53 -j DROP
iptables -D INPUT -p tcp --dport 53 -j DROP

# --- 2. Hapus aturan ALLOW akses DNS (TCP/UDP) dari Vilya ---
iptables -D INPUT -p udp --dport 53 -s $IP_VILYA -j ACCEPT
iptables -D INPUT -p tcp --dport 53 -s $IP_VILYA -j ACCEPT

# --- 3. Verifikasi Rule ---
echo "Aturan DNS yang dihapus seharusnya tidak lagi muncul:"
iptables -L INPUT -n | grep "dpt:53"

# --- 4. Jalankan Service (jika perlu mereset status) ---
echo "restart service named..."
service named restart