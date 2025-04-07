#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# IP ve domain bilgisi çekiliyor
MYIP=$(wget -qO- https://icanhazip.com)
echo -e "${green}VPS Kontrol Ediliyor...${NC}"
sleep 0.7
clear
echo -e "${green}Başlatılıyor...${NC}"
sleep 0.7

# Domain bilgisi okunuyor
source /var/lib/premium-script/ipvps.conf
domain=$IP

# V2Ray servislerini durdur
systemctl stop v2ray
systemctl stop v2ray@none

# ZeroSSL hesabına otomatik kayıt (zaten varsa hata vermez)
EMAIL="guzelim.batmanli@gmail.com"
/root/.acme.sh/acme.sh --register-account -m $EMAIL --server zerossl || true

# Sertifika alma ve kurma
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
/root/.acme.sh/acme.sh --installcert -d $domain \
  --fullchainpath /etc/v2ray/v2ray.crt \
  --keypath /etc/v2ray/v2ray.key \
  --ecc

# V2Ray servislerini başlat
systemctl start v2ray
systemctl start v2ray@none

# Bilgilendirme ve reboot
echo -e "[${green}Tamamlandı${NC}]"
echo "Sistem 5 saniye içinde yeniden başlatılacak..."
sleep 5
reboot
