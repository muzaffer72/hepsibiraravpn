#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
echo "VPS Kontrol Ediliyor"
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Kullanıcı Adı: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/v2ray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "Bu Kullanıcı Adı Zaten Var, Lütfen Yeni Bir Kullanıcı Adı Girin"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Son Kullanma Tarihi (gün): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vnone.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/v2ray&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/v2ray&encryption=none&type=ws#${user}"
systemctl restart v2ray@vless
systemctl restart v2ray@vnone
clear
echo -e ""
echo -e "==============================="
echo -e "V2RAY/VLESS Hesap Bilgisi"
echo -e "==============================="
echo -e "Açıklama      : ${user}"
echo -e "Domain        : ${domain}"
echo -e "TLS Portu     : $tls"
echo -e "None TLS Portu: $none"
echo -e "id            : ${uuid}"
echo -e "Şifreleme     : none"
echo -e "Ağ            : ws"
echo -e "Path          : /v2ray"
echo -e "==============================="
echo -e "TLS Linki     : ${vlesslink1}"
echo -e ""
echo -e "None TLS Linki: ${vlesslink2}"
echo -e "==============================="
echo -e "Son Kullanma Tarihi: $exp"
echo -e "Onvao.net Premium vpn Kurulum scripti"
echo -e ""
