#!/bin/bash

# 1. Terapkan rule untuk menolak ICMP Echo Request (Ping) yang masuk
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# 2. Verifikasi rule
echo "Konfigurasi Firewall Misi 2.2 Selesai."
echo "Menampilkan daftar rule iptables saat ini:"
echo "------------------------------------------"
iptables -L INPUT -v -n | grep icmp