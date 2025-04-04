#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
echo "VPS Kontrol Ediliyor"
IP=$(wget -qO- https://icanhazip.com);
date=$(date +"%Y-%m-%d")
clear
echo "Yedekleme Mesajını Almak İçin E-posta Adresinizi Girin"
read -rp "E-posta: " -e email
sleep 1
echo "Dizin Oluşturuluyor"
mkdir /root/backup
sleep 1
echo "Yedekleme Başlatılıyor"
clear
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/wireguard backup/wireguard
cp /etc/ppp/chap-secrets backup/chap-secrets
cp /etc/ipsec.d/passwd backup/passwd1
cp /etc/shadowsocks-libev/akun.conf backup/ss.conf
cp -r /var/lib/premium-script/ backup/premium-script
cp -r /home/sstp backup/sstp
cp -r /etc/v2ray backup/v2ray
cp -r /etc/trojan backup/trojan
cp -r /usr/local/shadowsocksr/ backup/shadowsocksr
cp -r /home/vps/public_html backup/public_html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "VPS Yedeklemeniz BAŞARILI

Lütfen Aşağıdaki Verileri Saklayın
============================================
VPS IP'niz : $IP
Yedekleme Linki : $link
============================================
Veri geri yüklemek isterseniz yukarıdaki bağlantıyı kullanın

© Copyright 2025 By onvao.net" | mail -s "Yedekleme Verisi" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo ""
figlet -c BİTTİ | lolcat
echo "Lütfen E-posta'nızı Kontrol Edin"
echo ""
