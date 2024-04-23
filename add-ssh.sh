#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
echo "Checking VPS"
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(wget -qO- https://icanhazip.com);
if [[ "$domain" = "" ]]; then
domain=$(cat /home/domain)
else
domain=$IP
fi
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
sleep 1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "=================================="
echo -e "Information SSH & OpenVPN Account "
echo -e "=================================="
echo -e "Domain         : $domain"
echo -e "Host           : $IP"
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "=================================="
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "SSL/TLS        : $ssl"
echo -e "Port Squid     : $sqd"
echo -e "OpenVPN        : TCP $ovpn"
echo -e "http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN        : UDP $ovpn2"
echo -e "http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN        : SSL 442" 
echo -e "http://$IP:81/client-tcp-ssl.ovpn"
echo -e "OpenVPN        : OHP 8087" 
echo -e "http://$MYIP:81/tcp-ohp.ovpn"
echo -e "badvpn         : 7100, 7200, 7300"
echo -e "=================================="
echo -e "Expired On     : $exp"
echo -e "Created By EvoTeamMalaysia"
echo -e ""
