#!/bin/bash
# ==========================================
# KONFIGURASI DNS SERVER (NARYA)
# Domain: k50.com
# ==========================================
echo nameserver 8.8.8.8 > /etc/resolv.conf

apt-get update
apt-get install bind9 dnsutils -y
# 1. Konfigurasi Options (Forwarder ke Google)
cat > /etc/bind/named.conf.options <<EOF
options {
        directory "/var/cache/bind";
        forwarders {
                8.8.8.8;
        };
        dnssec-validation auto;
        listen-on-v6 { any; };
        allow-query { any; };
};
EOF

# 2. Konfigurasi Zone (Local)
cat > /etc/bind/named.conf.local <<EOF
zone "k50.com" {
        type master;
        file "/etc/bind/jarkom/k50.com";
};

zone "1.236.192.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/1.236.192.in-addr.arpa";
};
EOF

# 3. Buat Folder & File Zone Forward
mkdir -p /etc/bind/jarkom

cat > /etc/bind/jarkom/k50.com <<EOF
;
; Forward Zone - k50.com
;
\$TTL    604800
@       IN      SOA     k50.com. root.k50.com. (
                        2023101001      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      narya.k50.com.
@       IN      A       192.236.1.195   ; IP Narya
narya   IN      A       192.236.1.195
vilya   IN      A       192.236.1.194
ironhills IN    A       192.236.1.202
palantir  IN    A       192.236.1.206
www       IN    CNAME   ironhills       ; Alias www ke IronHills
EOF

# 4. Buat File Zone Reverse
cat > /etc/bind/jarkom/1.236.192.in-addr.arpa <<EOF
;
; Reverse Zone (Subnet Server 192.236.1.x)
;
\$TTL    604800
@       IN      SOA     k50.com. root.k50.com. (
                        2023101001      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      narya.k50.com.
195     IN      PTR     narya.k50.com.
194     IN      PTR     vilya.k50.com.
202     IN      PTR     ironhills.k50.com.
206     IN      PTR     palantir.k50.com.
EOF

# 5. Restart Service (Paksa start binary manual jika service gagal)
if [ -f /usr/sbin/named ]; then
    /usr/sbin/named -u bind
fi
service bind9 restart
echo "DNS Server Narya (k50.com) Siap!"