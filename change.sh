#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
echo "VPS Kontrol Ediliyor"
clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "     [1]  Stunnel4 Portunu Değiştir"
echo -e "     [2]  OpenVPN Portunu Değiştir"
echo -e "     [3]  Wireguard Portunu Değiştir"
echo -e "     [4]  Vmess Portunu Değiştir"
echo -e "     [5]  Vless Portunu Değiştir"
echo -e "     [6]  Trojan Portunu Değiştir"
echo -e "     [7]  Squid Portunu Değiştir"
echo -e "     [8]  SSTP Portunu Değiştir"
echo -e "     [x]  Çıkış"
echo -e "======================================"
echo -e ""
read -p "     Seçeneklerden birini seçin [1-8 veya x] :  " port
echo -e ""
case $port in
1)
port-ssl
;;
2)
port-ovpn
;;
3)
port-wg
;;
4)
port-ws
;;
5)
port-vless
;;
6)
port-tr
;;
7)
port-squid
;;
8)
port-sstp
;;
x)
clear
menu
;;
*)
echo "Lütfen doğru bir numara girin"
;;
esac
