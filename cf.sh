#!/bin/bash

# Renk tanımları
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# IP ve alan adı tanımı
MYIP=$(wget -qO- https://icanhazip.com)
DOMAIN=onvao.net
sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
SUB_DOMAIN="${sub}.${DOMAIN}"
WILDCARD="*.${sub}.${DOMAIN}"

# Cloudflare API Token (Global Key değil!)
CF_TOKEN="GS-PuGOJEk_rQWkmfglORvxxQ1Yw9SK_r3vew_lB"

echo -e "${green}VPS IP: $MYIP${NC}"
echo -e "${green}Subdomain oluşturuluyor: $SUB_DOMAIN${NC}"

# jq ve curl kurulumunu sağla
apt install -y jq curl >/dev/null 2>&1

# Zone ID'yi al
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}" \
     -H "Authorization: Bearer ${CF_TOKEN}" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

if [[ -z "$ZONE" || "$ZONE" == "null" ]]; then
    echo -e "${red}HATA: ZONE ID alınamadı. Domain Cloudflare hesabında olmayabilir.${NC}"
    exit 1
fi

# Subdomain için DNS kaydı kontrolü
RECORD_ID=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "Authorization: Bearer ${CF_TOKEN}" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

if [[ -z "$RECORD_ID" || "$RECORD_ID" == "null" ]]; then
    echo -e "${green}Yeni DNS kaydı oluşturuluyor...${NC}"
    CREATE_RESULT=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
        -H "Authorization: Bearer ${CF_TOKEN}" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"name\":\"${SUB_DOMAIN}\",\"content\":\"${MYIP}\",\"ttl\":120,\"proxied\":false}")
    echo "$CREATE_RESULT" | jq .
else
    echo -e "${green}DNS kaydı güncelleniyor...${NC}"
    UPDATE_RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD_ID}" \
        -H "Authorization: Bearer ${CF_TOKEN}" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"name\":\"${SUB_DOMAIN}\",\"content\":\"${MYIP}\",\"ttl\":120,\"proxied\":false}")
    echo "$UPDATE_RESULT" | jq .
fi

# Subdomain yaz
echo "$SUB_DOMAIN" > /root/domain
echo -e "${green}Host oluşturuldu: ${SUB_DOMAIN}${NC}"

# Wildcard işlemi (uyarı: Cloudflare *.sub.domain için A kaydı kabul etmeyebilir)
echo -e "${green}Wildcard DNS kaydı oluşturuluyor: ${WILDCARD}${NC}"

# Cloudflare sadece 1 seviye wildcard destekler. CNAME olarak denenebilir.
WILDCARD_RECORD_ID=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILDCARD}" \
     -H "Authorization: Bearer ${CF_TOKEN}" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

if [[ -z "$WILDCARD_RECORD_ID" || "$WILDCARD_RECORD_ID" == "null" ]]; then
    curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
        -H "Authorization: Bearer ${CF_TOKEN}" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"name\":\"${WILDCARD}\",\"content\":\"${MYIP}\",\"ttl\":120,\"proxied\":false}" | jq .
else
    curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${WILDCARD_RECORD_ID}" \
        -H "Authorization: Bearer ${CF_TOKEN}" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"name\":\"${WILDCARD}\",\"content\":\"${MYIP}\",\"ttl\":120,\"proxied\":false}" | jq .
fi

echo "$WILDCARD" > /home/wildcard
rm -f /root/cf.sh
echo -e "${green}DNS işlemleri tamamlandı.${NC}"

