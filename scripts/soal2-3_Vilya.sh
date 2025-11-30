#!/bin/bash
# ==========================================
# Verifikasi Misi 2.3 dari Sisi VILYA
# Tujuan: Install Netcat & Tes Akses ke Narya
# ==========================================

IP_NARYA="192.236.1.195"

# 1. Cek & Install Netcat jika belum ada
if ! command -v nc &> /dev/null; then
    echo "[INFO] Netcat tidak ditemukan. Memulai instalasi..."

    # Pastikan bisa resolve DNS Google untuk download
    echo "nameserver 8.8.8.8" > /etc/resolv.conf

    apt-get update
    # Menginstall netcat (versi openbsd yang umum dipakai)
    apt-get install netcat-openbsd -y
else
    echo "[INFO] Netcat sudah terinstal."
fi

echo "MULAI PENGUJIAN AKSES KE NARYA ($IP_NARYA)"
echo "Target: Port 53 (DNS)"

# 2. Tes Port UDP 53 (Mode Default DNS)
echo "[TEST UDP] Mencoba koneksi UDP..."
nc -z -v -u $IP_NARYA 53

echo ""

# 3. Tes Port TCP 53 (Mode Zone Transfer)
echo "[TEST TCP] Mencoba koneksi TCP..."
nc -z -v $IP_NARYA 53
