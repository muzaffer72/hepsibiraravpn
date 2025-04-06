#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

MYIP=$(wget -qO- https://icanhazip.com)
echo "Checking VPS"
apt install jq curl -y

DOMAIN=onvao.net
sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
SUB_DOMAIN=${sub}.onvao.net
WILDCARD=*.${sub}.onvao.net

CF_API_TOKEN="GS-PuGOJEk_rQWkmfglORvxxQ1Yw9SK_r3vew_lB"
set -euo pipefail
IP=$(wget -qO- https://icanhazip.com)
echo "Updating DNS for ${SUB_DOMAIN}..."

ZONE=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')

echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /root/domain
sleep 5

echo "Updating DNS for ${WILDCARD}..."

ZONE=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILDCARD}" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${WILDCARD}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${WILDCARD}'","content":"'${IP}'","ttl":120,"proxied":false}')

echo "Host : $WILDCARD"
echo $WILDCARD > /home/wildcard
rm -f /root/cf.sh
