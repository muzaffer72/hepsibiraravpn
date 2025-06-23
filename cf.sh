#!/bin/bash

# Renk tanımları
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# IP ve alan adı tanımı
MYIP=$(wget -qO- https://icanhazip.com)
DOMAIN=onvao.net # Ana domain sabit kalıyor

# Cloudflare API Token (Global Key değil!)
CF_TOKEN="QKLitlP3Sou_YaqIiMpJR7_13h0GGQ6iPs2swHrm" # Tokeninizi buraya girin

echo -e "${green}VPS IP: $MYIP${NC}"

# Kullanıcıdan subdomain girişi al
read -rp "$(echo -e "${green}Lütfen kullanmak istediğiniz subdomain'i girin (örn: myapp.onvao.net). Boş bırakırsanız rastgele oluşturulacaktır: ${NC}")" USER_SUB_DOMAIN

if [[ -z "$USER_SUB_DOMAIN" ]]; then
    sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
    SUB_DOMAIN="${sub}.${DOMAIN}"
    echo -e "${green}Rastgele subdomain oluşturuluyor: $SUB_DOMAIN${NC}"
else
    # Eğer kullanıcı sadece subdomain kısmını girerse (örn: "myapp"), ana domain'i ekleyelim.
    if [[ "$USER_SUB_DOMAIN" != *".$DOMAIN"* ]]; then
        SUB_DOMAIN="${USER_SUB_DOMAIN}.${DOMAIN}"
    else
        SUB_DOMAIN="$USER_SUB_DOMAIN"
    fi
    echo -e "${green}Kullanıcı tarafından belirtilen subdomain kullanılıyor: $SUB_DOMAIN${NC}"
fi

WILDCARD="*.${SUB_DOMAIN}" # Wildcard, oluşturulan subdomain'e göre ayarlanır.

# jq ve curl kurulumunu sağla
apt install -y jq curl >/dev/null 2>&1

# Zone ID'yi al
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}" \
      -H "Authorization: Bearer ${CF_TOKEN}" \
      -H "Content-Type: application/json" | jq -r '.result[0].id')

if [[ -z "$ZONE" || "$ZONE" == "null" ]]; then
    echo -e "${red}HATA: ZONE ID alınamadı. Domain Cloudflare hesabında olmayabilir veya token geçersiz.${NC}"
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
echo "$SUB_DOMAIN" > /home/domain
echo "$SUB_DOMAIN" > /root/domain
echo -e "${green}Host oluşturuldu: ${SUB_DOMAIN}${NC}"



## Wildcard DNS Kaydı Oluşturuluyor


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
