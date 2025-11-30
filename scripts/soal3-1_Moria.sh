#!/bin/bash
# Minta Input
read -p "Subnet Khamul: " SUBNET_KHAMUL

# Apply Rule
iptables -A FORWARD -s $SUBNET_KHAMUL -j DROP
iptables -A FORWARD -d $SUBNET_KHAMUL -j DROP

echo "Rule Isolasi Applied."
echo "Test:"
echo "1. Dari Khamul: ping 8.8.8.8 (Harus Gagal)"
echo "2. Dari Durin: ping 8.8.8.8 (Harus Sukses)"