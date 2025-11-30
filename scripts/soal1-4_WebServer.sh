#!/bin/bash
# ==========================================
# MISI 1: Setup Web Server (IronHills & Palantir)
# ==========================================

# 1. Set DNS ke Google dulu biar bisa apt update
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 2. Update repo dan install Nginx
apt-get update
apt-get install nginx -y

echo "Starting Nginx manually..."
if [ -f /etc/init.d/nginx ]; then
    /etc/init.d/nginx start
else
    # Fallback kalau init script ga ada/gagal
    /usr/sbin/nginx
fi

# Pastikan service status running
service nginx status || echo "Nginx status check skipped (container limitation)"

# 4. Soal Misi 1: Buat index.html berisikan "Welcome to {hostname}"
echo "Welcome to $(hostname)" > /var/www/html/index.html

# 5. Cek hasil
echo "----------------------------------------"
echo "Cek akses Localhost:"
curl localhost
echo "----------------------------------------"
echo "Instalasi Web Server di $(hostname) Selesai."