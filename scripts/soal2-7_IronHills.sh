#!/bin/bash
# Apply Rule (Insert paling atas)
iptables -R INPUT 1 -p tcp --syn --dport 80 -m connlimit --connlimit-above 3 -j REJECT --reject-with tcp-reset

echo "Ya ya ya sudah di apply"
echo "Test di Client:"
echo "1. Set tanggal laptop jadi sabtu cuy"
echo "2. Install ab: apt install apache2-utils -y"
echo "3. Run Test: ab -n 100 -c 10 http://192.236.1.202/"