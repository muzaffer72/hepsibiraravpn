#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'

# Domain Girişi
clear
echo ""
echo -e "${BLUE}==========================================================${NC}"
figlet Domain Ekle | lolcat
echo -e "${BLUE}==========================================================${NC}"
echo ""
echo "Lütfen Cloudflare üzerinde yönlendirdiğiniz domaininizi girin"
read -rp "Domain/Host: " -e host
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
rm -f /home/domain
echo "$host" > /home/domain
echo -e "[${GREEN}Tamamlandı${NC}]"

# SSL Sertifikası Güncellemesi
echo "Sertifikanız otomatik olarak güncelleniyor"
sleep 3
echo "SSL Sertifikası Güncelleniyor"
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP

# V2Ray servislerini durdur
systemctl stop v2ray
systemctl stop v2ray@none

# ZeroSSL hesabına otomatik kayıt (zaten varsa geçer)
EMAIL="guzelim.batmanli@gmail.com"
/root/.acme.sh/acme.sh --register-account -m $EMAIL --server zerossl || true

# Sertifika alma ve kurma
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
/root/.acme.sh/acme.sh --installcert -d $domain \
  --fullchainpath /etc/v2ray/v2ray.crt \
  --keypath /etc/v2ray/v2ray.key \
  --ecc

# Servisleri yeniden başlat
systemctl start v2ray
systemctl start v2ray@none

# İşlem Tamamlandı
echo -e "[${GREEN}Tamamlandı${NC}]"
echo "Domaininizin Konumu : /home/domain"
echo ""
echo -e "${RED}Onvao.net Premium VPN Kurulum scripti${NC}"
