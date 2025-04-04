#!/bin/bash
#onvao.net Projesi ile HTTP Puncher Aç
#Direct Proxy Squid For OpenVPN TCP
#Telegram: @onvaonet
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

#VPS Depolarını Güncelle
clear
apt update 
apt-get -y upgrade

#Sunucu Portları
#Portu Değiştirmek İstiyorsanız VPS'inizdeki Portla Uygun Olarak Ayarlayın
Port_OpenVPN_TCP='1194';
Port_Squid='3128';
Port_OHP='8087';

#OHP Sunucusunu Yükle
cd 
wget -O /usr/local/bin/ohp "https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/ohp"
chmod +x /usr/local/bin/ohp

#OpenVPN TCP OHP Dosyası Oluştur
cat > /etc/openvpn/tcp-ohp.ovpn <<END
############# HOŞGELDİNİZ #############
########## SHADOWSOCKS VPN / IKEV2 VPN ############
###### ONVAONET OHP SERVER ########
setenv CLIENT_CERT 0
setenv opt block-outside-dns
client
dev tun
proto tcp
remote "bug" 1194
persist-tun
persist-key
persist-remote-ip
comp-lzo
reneg-sec 0
pull
resolv-retry infinite
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
script-security 2
tls-version-min 1.2
tls-cipher TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256

http-proxy xxxxxxxxx 8087
http-proxy-option VERSION 1.1
http-proxy-option CUSTOM-HEADER ""
http-proxy-option CUSTOM-HEADER "Host: "
http-proxy-option CUSTOM-HEADER "X-Forwarded-Host: "
http-proxy-option CUSTOM-HEADER ""
END

sed -i $MYIP2 /etc/openvpn/tcp-ohp.ovpn;

#Certifikayı TCP 1194 istemci konfigürasyonuna ekle
echo '<ca>' >> /etc/openvpn/tcp-ohp.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/tcp-ohp.ovpn
echo '</ca>' >> /etc/openvpn/tcp-ohp.ovpn
cp /etc/openvpn/tcp-ohp.ovpn /home/vps/public_html/tcp-ohp.ovpn
clear
cd 

#OHP için Servis Oluştur
cat > /etc/systemd/system/ohp.service <<END
[Unit]
Description=Direct Squid Proxy For OpenVPN TCP By ONVAONET
Documentation=https://t.me/onvaonet
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohp -port 8087 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ohp
systemctl restart ohp
echo ""
echo -e "${GREEN}OHP Sunucusu Başarıyla Kuruldu${NC}"
echo -e "Port OVPN OHP TCP: $ohpp"
echo -e "OVPN OHP İndirme Linki: http://$MYIP:81/tcp-ohp.ovpn"
echo -e "Onvao.net Premium VPN Kurulum Scripti"
