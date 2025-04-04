#!/bin/bash
set -euo pipefail

# Renkler
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# Gereksinimler
apt update -y && apt install -y jq curl

# Bilgiler
DOMAIN="onvao.net"
SUB=$(</dev/urandom tr -dc a-z0-9 | head -c4)
SUB_DOMAIN="${SUB}.${DOMAIN}"
WILDCARD="*.${SUB}.${DOMAIN}"
IP=$(curl -s https://icanhazip.com)

# Cloudflare bilgiler (dilersen .env dosyasından da alabilirsin)
CF_EMAIL="guzelim.batmanli@gmail.com"
CF_KEY="4aa140cf85fde3adadad1856bdf67cf5ad460"

echo -e "${green}IP adresin: ${IP}${NC}"
echo -e "${green}Subdomain: ${SUB_DOMAIN}${NC}"
echo -e "${green}Wildcard: ${WILDCARD}${NC}"

# Zone ID'yi al
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_EMAIL}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

update_dns_record() {
    local RECORD_NAME=$1

    # Kayıt var mı kontrol et
    RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?name=${RECORD_NAME}" \
        -H "X-Auth-Email: ${CF_EMAIL}" \
        -H "X-Auth-Key: ${CF_KEY}" \
        -H "Content-Type: application/json" | jq -r '.result[0].id')

    if [[ "${#RECORD_ID}" -le 10 ]]; then
        # Yoksa oluştur
        echo -e "${green}${RECORD_NAME} için yeni A kaydı ekleniyor...${NC}"
        RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records" \
            -H "X-Auth-Email: ${CF_EMAIL}" \
            -H "X-Auth-Key: ${CF_KEY}" \
            -H "Content-Type: application/json" \
            --data '{"type":"A","name":"'"${RECORD_NAME}"'","content":"'"${IP}"'","ttl":120,"proxied":false}')
    else
        # Varsa güncelle
        echo -e "${green}${RECORD_NAME} için A kaydı güncelleniyor...${NC}"
        RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID}" \
            -H "X-Auth-Email: ${CF_EMAIL}" \
            -H "X-Auth-Key: ${CF_KEY}" \
            -H "Content-Type: application/json" \
            --data '{"type":"A","name":"'"${RECORD_NAME}"'","content":"'"${IP}"'","ttl":120,"proxied":false}')
    fi

    # Başarı kontrolü
    if echo "$RESPONSE" | jq -e '.success' > /dev/null; then
        echo -e "${green}Başarılı: ${RECORD_NAME} IP ${IP} olarak ayarlandı.${NC}"
    else
        echo -e "${red}HATA: ${RECORD_NAME} kaydı eklenemedi/güncellenemedi.${NC}"
        echo "$RESPONSE"
    fi
}

# Subdomain ve wildcard kaydını işle
update_dns_record "$SUB_DOMAIN"
update_dns_record "$WILDCARD"

# Sonuçları yaz
echo "$SUB_DOMAIN" > /root/domain
echo "$WILDCARD" > /home/wildcard

# Temizlik
rm -f /root/cf.sh
