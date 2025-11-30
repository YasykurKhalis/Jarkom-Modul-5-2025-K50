#!/bin/bash
read -p "Masukkan IP Client Khamul (Target, cth: 192.236.1.130): " IP_KHAMUL
read -p "Masukkan IP IronHills (Tujuan, cth: 192.236.1.202): " IP_IRONHILLS

# 2. Apply NAT Rule
# Reset NAT Output biar bersih
iptables -t nat -F OUTPUT

echo "[*] Menerapkan Sihir Pengalihan (DNAT)..."
# Rule: Traffic OUTPUT (dari diri sendiri) dengan tujuan Khamul -> Ganti Destination jadi IronHills
iptables -t nat -A OUTPUT -d $IP_KHAMUL -j DNAT --to-destination $IP_IRONHILLS

echo "Test di client: nc -v $IP_KHAMUL 80"