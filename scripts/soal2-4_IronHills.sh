#!/bin/bash
echo "=== SOLVER MISI 2.4: WEEKEND ACCESS ONLY ==="
echo "Node Target: IronHills"
echo "--------------------------------------------"

# 1. Input IP Dinamis
read -p "Masukkan Subnet Faksi Kurcaci (Durin & Khamul, cth: 192.236.1.128/26): " IP_KURCACI
read -p "Masukkan Subnet Faksi Manusia (Elendil & Isildur, cth: 192.236.0.0/24): " IP_MANUSIA

echo "[*] Menerapkan aturan akses Sabtu-Minggu..."
# Allow Kurcaci & Manusia di hari Sabtu & Minggu
iptables -A INPUT -p tcp --dport 80 -s $IP_KURCACI -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s $IP_MANUSIA -m time --weekdays Sat,Sun -j ACCEPT

# Block sisa akses web
iptables -A INPUT -p tcp --dport 80 -j DROP

echo "[OK] Rules Berhasil Diterapkan."
echo "--------------------------------------------"
echo "TEST: Pake Curl aja di Client tadi, terus coba ganti tanggal di PC (ya PC sendiri awikwok)"