#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "Doğru şekilde kurulum yapmak için bu betiği root/yönetici olarak çalıştırmanız gerekir"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ desteklenmiyor"
		exit 1
fi
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
# Variable Warna
based="\e[39m"
danger="\e[91m"
warning="\e[93m"
success="\e[92m"

echo -e "\n[${warning}Permission$based] > Şifreyi Girin :"
read -r -s Password
case "$Password" in
  005434677197 )
    echo -e "\n[${success}SUCCESS$based] > Şifre doğru"
    echo -e "[${warning}Output$based]  > Sana izin var :)"
  ;;
  * )
    echo -e "\n[${danger}ERROR$based]  > Yanlış şifre"
    echo -e "[${warning}Output$based] > sana izin verilmiyor :'("
  ;;
esac

if [ -f "/etc/v2ray/domain" ]; then
echo "Komut Dosyası Zaten Yüklendi"
exit 0
fi
mkdir /var/lib/premium-script;
echo "IP=" >> /var/lib/premium-script/ipvps.conf
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/cf.sh && chmod +x cf.sh && ./cf.sh
#install ssh ovpn
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#sstp
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/sstp.sh && chmod +x sstp.sh && ./sstp.sh
#install ssr
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/ssr.sh && chmod +x ssr.sh && ./ssr.sh
#sodosok
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/sodosok.sh && chmod +x sodosok.sh && ./sodosok.sh
#installwg
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/wg.sh && chmod +x wg.sh && ./wg.sh
#install v2ray
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/ins-vt.sh && chmod +x ins-vt.sh && ./ins-vt.sh
#install L2TP
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/ipsec.sh && chmod +x ipsec.sh && ./ipsec.sh
#br-set
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Set Index
cd /home/vps/public_html
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/refs/heads/main/index.html
#install ohp-server
wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/main/ohp.sh && chmod +x ohp.sh && ./ohp.sh
cd
#install figlet & lolcat
sudo apt-get install figlet
sudo apt-get install ruby
sudo gem install lolcat

rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-vt.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/ohp.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://www.onvao.net

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
history -c
echo "1.2" > /home/ver
clear
echo " "
sudo hostnamectl set-hostname aio.onvao.net
figlet -c Kurulum Başarılı | lolcat
echo " "
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo "========================== Premium Otomatik Kurulum scripti=======================" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 442, OHP 8087"  | tee -a log-install.txt
echo "   - Stunnel4                : 443, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (IP Sunucusu sınırı)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 8880"  | tee -a log-install.txt
echo "   - Trojan                  : 2087"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Sunucu Bilgileri ve Diğer Özellikler"  | tee -a log-install.txt
echo "   - Saat Dilimi                : Europa/Istanbul(GMT +3)"  | tee -a log-install.txt
echo "   - hostname               : aio.onvao.net"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Otomatik Yeniden Başlatma             : [OFF]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Otomatik veri Yedekleme" | tee -a log-install.txt
echo "   - Verileri Geri Yükle" | tee -a log-install.txt
echo "   - Süresi Dolan Hesabı Otomatik Olarak Sil" | tee -a log-install.txt
echo "   - Çeşitli Hizmetler İçin Tam Siparişler" | tee -a log-install.txt
echo "   - Beyaz Etiket" | tee -a log-install.txt
echo "   - Kurulum Günlüğü --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Script Sahibi               : Onvao.net " | tee -a log-install.txt
echo "   - Telegram                : T.me/onvaovpn"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "================================================================================" | tee -a log-install.txt
echo "----------------------------- Muzaffer Şanlı onvao.net -------------------------------" | tee -a log-install.txt
echo "================================================================================" | tee -a log-install.txt
echo ""
echo "	 Kurulum tamamlandı ve saat dilimi istanbul olarak ayarlanıyor 6 saniye içinde Sunucu tekrar başlatılacak."
rm -f install.sh
sudo timedatectl set-timezone Europe/Istanbul
sleep 6
reboot
