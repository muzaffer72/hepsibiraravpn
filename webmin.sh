#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
echo "VPS Kontrol Ediliyor"

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[Yüklü]${Font_color_suffix}"
Error="${Red_font_prefix}[Yüklü Değil]${Font_color_suffix}"
cek=$(netstat -ntlp | grep 10000 | awk '{print $7}' | cut -d'/' -f2)

function install () {
IP=$(wget -qO- ifconfig.co);
echo "Webmin Reposu Ekleniyor"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
apt install gnupg gnupg1 gnupg2 -y
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
echo "Webmin Yükleniyor"
clear
sleep 0.5
apt update > /dev/null 2>&1
apt install webmin -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
/etc/init.d/webmin restart
rm -f /root/jcameron-key.asc
clear
echo ""
echo "Webmin Yükleme Tamamlandı"
echo " $IP:10000"
echo "Onvao.net Premium VPN Kurulum scripti"
}

function restart () {
echo "Webmin Yeniden Başlatılıyor"
sleep 0.5
service webmin restart > /dev/null 2>&1
echo "Webmin Yeniden Başlatma Başlatıldı"
clear
echo ""
echo "Webmin Yeniden Başlatma Tamamlandı"
echo "Onvao.net Premium VPN Kurulum scripti"
}

function uninstall () {
echo "Webmin Reposu Kaldırılıyor"
rm -f /etc/apt/sources.list.d/webmin.list
apt update > /dev/null 2>&1
echo "Webmin Kaldırılmaya Başlanıyor"
clear
sleep 0.5
apt autoremove --purge webmin -y > /dev/null 2>&1
clear
echo ""
echo "Webmin Kaldırma Tamamlandı"
echo "AutoScriptVPS By EvoTeamMalaysia"
}

if [[ "$cek" = "perl" ]]; then
sts="${Info}"
else
sts="${Error}"
fi

clear
echo -e " =============================="
echo -e "           Webmin Menüsü       "
echo -e " =============================="
echo -e " Durum $sts"
echo -e "  1. Webmin Yükle"
echo -e "  2. Webmin Yeniden Başlat"
echo -e "  3. Webmin Kaldır"
echo -e " Onvao.net Premium VPN Kurulum scripti"
echo -e " Geri dönmek için CTRL+C'ye basın"
read -rp " Lütfen Doğru Numarayı Giriniz : " -e num
if [[ "$num" = "1" ]]; then
install
elif [[ "$num" = "2" ]]; then
restart
elif [[ "$num" = "3" ]]; then
uninstall
else
clear
echo "Yanlış Numara Girdiniz"
menu
fi
