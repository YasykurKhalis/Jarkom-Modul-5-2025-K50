#!/bin/bash
# ==========================================
# KONFIGURASI DHCP RELAY (UNIVERSAL)
# Target Node: Minastir, AnduinBanks, Rivendell, Wilderland
# ==========================================

# IP DHCP SERVER (VILYA)
TARGET_SERVER="192.236.1.194"

echo "Mengonfigurasi DHCP Relay arah ke $TARGET_SERVER..."

# 1. Pastikan DNS aman buat install
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update

# 2. Install Paket (Mode Non-Interactive)
DEBIAN_FRONTEND=noninteractive apt-get install isc-dhcp-relay -y

# 3. Masukkan Konfigurasi Relay
# SERVERS: Alamat DHCP Server (Vilya)
# INTERFACES: Semua interface (eth0-eth3) diset agar relay mendengar dari segala arah
cat > /etc/default/isc-dhcp-relay <<EOF
SERVERS="$TARGET_SERVER"
INTERFACES="eth0 eth1 eth2 eth3"
OPTIONS=""
EOF

# 4. Aktifkan IP Forwarding (Wajib bagi Relay/Router)
# Cek apakah sudah ada, kalau belum tambahkan
if ! grep -q "net.ipv4.ip_forward=1" /etc/sysctl.conf; then
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
else
    sed -i '/net.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf
fi
sysctl -p

# 5. Restart Service
service isc-dhcp-relay restart

# 6. Verifikasi
echo "----------------------------------------"
if service isc-dhcp-relay status | grep -q "Active: active"; then
    echo "[SUKSES] Relay aktif! Siap meneruskan request ke Vilya."
else
    echo "[WARNING] Service belum aktif. Coba jalankan 'service isc-dhcp-relay start' manual."
fi
