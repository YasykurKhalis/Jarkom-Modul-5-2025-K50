#!/bin/bash

iptables -N LOGDROP
# Log packet (Level 4 warning)
iptables -A LOGDROP -j LOG --log-prefix "PORT_SCAN_DETECTED " --log-level 4
# Drop packet
iptables -A LOGDROP -j DROP

# "Kalau IP ini ada di list 'scanner' dan udah hit > 15x, update timer & TENDANG ke LOGDROP"
iptables -A INPUT -m recent --name scanner --update --seconds 20 --hitcount 15 -j LOGDROP

# "Kalau paket TCP SYN baru dateng, catat IP-nya ke list 'scanner'"
iptables -A INPUT -p tcp --syn -m recent --name scanner --set

# Kalau user normal (hitcount < 15), izinkan akses port 80 (Shift Kerja Logic bisa masuk sini nanti)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

echo "[SUKSES] Proteksi Port Scan Aktif."
echo "TEST: Lakuin di Client Yak"
echo "1. Test Nmap: nmap 192.236.1.206"
echo "2. Selesai nmap langsung cepet cepet: ping 192.236.1.206"
echo "3. Nah ini lihat log di Node ini: iptables -vnL LOGDROP"