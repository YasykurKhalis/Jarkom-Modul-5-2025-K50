#!/bin/bash
# ==========================================
# KONFIGURASI DHCP SERVER (VILYA)
# ==========================================
echo nameserver 8.8.8.8 > /etc/resolv.conf

apt-get update
apt-get install isc-dhcp-server -y

# 1. Pastikan interface diset
sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/g' /etc/default/isc-dhcp-server

# 2. Tulis konfigurasi dhcpd.conf
cat > /etc/dhcp/dhcpd.conf <<EOF
# Global Config
default-lease-time 600;
max-lease-time 7200;
option domain-name "k50.com";
option domain-name-servers 192.236.1.195, 8.8.8.8; # IP Narya & Google

# Subnet D (Jaringan Lokal Vilya - Wajib ada)
subnet 192.236.1.192 netmask 255.255.255.248 {
}

# Subnet A (Switch4 - Elendil/Isildur)
subnet 192.236.0.0 netmask 255.255.255.0 {
    range 192.236.0.10 192.236.0.250;
    option routers 192.236.0.1;
    option broadcast-address 192.236.0.255;
}

# Subnet B (Switch5 - Gilgalad/Cirdan)
subnet 192.236.1.0 netmask 255.255.255.128 {
    range 192.236.1.10 192.236.1.120;
    option routers 192.236.1.1;
    option broadcast-address 192.236.1.127;
}

# Subnet C (Switch3 - Durin/Khamul)
subnet 192.236.1.128 netmask 255.255.255.192 {
    range 192.236.1.130 192.236.1.190;
    option routers 192.236.1.129;
    option broadcast-address 192.236.1.191;
}
EOF

# 3. Restart Service
service isc-dhcp-server restart
service isc-dhcp-server status | grep "Active"
echo "DHCP Server Configured!"