#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'

clear
echo -e ""
echo -e "${BLUE}=================================================================${NC}"
echo -e "${GREEN}=================================================================${NC}"
figlet onvaonet | lolcat
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}======================= ${RED}SSH & OpenVPN Menüsü ${BLUE}======================${NC}"
echo -e ""
echo -e "- add-ssh      : SSH & OpenVPN Hesabı Oluştur" | lolcat
echo -e "- trial-ssh    : SSH & OpenVPN Deneme Hesabı Oluştur" | lolcat
echo -e "- renew-ssh    : SSH & OpenVPN Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- del-ssh      : SSH & OpenVPN Hesabını Sil" | lolcat
echo -e "- cek-ssh      : SSH & OpenVPN Kullanıcı Girişini Kontrol Et" | lolcat
echo -e "- list-ssh     : SSH & OpenVPN Üye Listesi" | lolcat
echo -e "- delete       : Süresi Dolmuş SSH & OpenVPN Kullanıcılarını Sil" | lolcat
echo -e "- autokill     : SSH İçin Autokill Ayarla" | lolcat
echo -e "- mulog        : Birden Fazla SSH Girişi Yapan Kullanıcıları Göster" | lolcat
echo -e "- restart      : Dropbear, Squid3, OpenVPN ve SSH Servislerini Yeniden Başlat" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}========================= ${RED}Wireguard Menüsü ${BLUE}========================${NC}"
echo -e ""
echo -e "- add-wg       : Wireguard Hesabı Oluştur" | lolcat
echo -e "- del-wg       : Wireguard Hesabını Sil" | lolcat
echo -e "- cek-wg       : Wireguard Kullanıcı Girişini Kontrol Et" | lolcat
echo -e "- renew-wg     : Wireguard Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- wg show      : Wireguard Kullanıcı Arayüzünü Kontrol Et" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}L2TP Menüsü ${BLUE}===========================${NC}"
echo -e ""
echo -e "- add-l2tp     : L2TP Hesabı Oluştur" | lolcat
echo -e "- del-l2tp     : L2TP Hesabını Sil" | lolcat
echo -e "- renew-l2tp   : L2TP Hesabı Aktif Süresini Uzat" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}PPTP Menüsü ${BLUE}===========================${NC}"
echo -e ""
echo -e "- add-pptp     : PPTP Hesabı Oluştur" | lolcat
echo -e "- del-pptp     : PPTP Hesabını Sil" | lolcat
echo -e "- renew-pptp   : PPTP Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- cek-pptp     : PPTP Kullanıcı Girişini Kontrol Et" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}SSTP Menüsü ${BLUE}===========================${NC}"
echo -e ""
echo -e "- add-sstp     : SSTP Hesabı Oluştur" | lolcat
echo -e "- del-sstp     : SSTP Hesabını Sil" | lolcat
echo -e "- renew-sstp   : SSTP Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- cek-sstp     : SSTP Kullanıcı Girişini Kontrol Et" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}SSR Menüsü ${BLUE}============================${NC}"
echo -e ""
echo -e "- add-ssr      : SSR Hesabı Oluştur" | lolcat
echo -e "- del-ssr      : SSR Hesabını Sil" | lolcat
echo -e "- renew-ssr    : SSR Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- ssr          : Diğer SSR Menüsünü Göster" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}======================== ${RED}Shadowsocks OBFS Menüsü ${BLUE}=======================${NC}"
echo -e ""
echo -e "- add-ss       : Shadowsocks Hesabı Oluştur" | lolcat
echo -e "- del-ss       : Shadowsocks Hesabını Sil" | lolcat
echo -e "- renew-ss     : Shadowsocks Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- cek-ss       : Shadowsocks Kullanıcı Girişini Kontrol Et" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}VMESS Menüsü ${BLUE}==========================${NC}"
echo -e ""
echo -e "- add-ws       : V2ray Vmess WS Hesabı Oluştur" | lolcat
echo -e "- del-ws       : V2ray Vmess WS Hesabını Sil" | lolcat
echo -e "- renew-ws     : Vmess Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- cek-ws       : V2ray Kullanıcı Girişini Kontrol Et" | lolcat
echo -e "- cert2vray    : V2ray Hesabı Sertifikasını Yenile" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}VLESS Menüsü ${BLUE}==========================${NC}"
echo -e ""
echo -e "- add-vless    : V2ray Vless WS Hesabı Oluştur" | lolcat
echo -e "- del-vless    : V2ray Vless WS Hesabını Sil" | lolcat
echo -e "- renew-vless  : Vless Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- cek-vless    : V2ray Kullanıcı Girişini Kontrol Et" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}========================== ${RED}Trojan Menüsü ${BLUE}==========================${NC}"
echo -e ""
echo -e "- add-tr       : Trojan Hesabı Oluştur" | lolcat
echo -e "- del-tr       : Trojan Hesabını Sil" | lolcat
echo -e "- renew-tr     : Trojan Hesabı Aktif Süresini Uzat" | lolcat
echo -e "- cek-tr       : Trojan Kullanıcı Girişini Kontrol Et" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}========================== ${RED}Sistem Menüsü ${BLUE}==========================${NC}"
echo -e ""
echo -e "- auto-reboot  : VPS için Otomatik Yeniden Başlatma Ayarla" | lolcat
echo -e "- change-port  : Bazı Servislerin Portlarını Değiştir" | lolcat
echo -e "- autobackup   : VPS Verilerini Otomatik Yedekle" | lolcat
echo -e "- backup       : VPS Verilerini Yedekle" | lolcat
echo -e "- restore      : VPS Verilerini Geri Yükle" | lolcat
echo -e "- webmin       : Webmin Menüsü" | lolcat
echo -e "- kernel-up    : En Son Kernel'e Güncelle" | lolcat
echo -e "- vnstat       : Sunucu Bandwidth Kullanımını Kontrol Et" | lolcat
echo -e "- speed-limiter: Sunucu Bandwidth Hızını Sınırla" | lolcat
echo -e "- ram          : VPS RAM Kullanımını Kontrol Et" | lolcat
echo -e "- reboot       : VPS'yi Yeniden Başlat" | lolcat
echo -e "- speedtest    : VPS Hız Testi" | lolcat
echo -e "- update       : En Son Script Sürümüne Güncelle" | lolcat
echo -e "- info         : Sistem Bilgilerini Göster" | lolcat
echo -e "- about        : Script Hakkında Bilgi" | lolcat
echo -e "- exit         : VPS Terminal'den Çık" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "===================== ${RED}Onvao.net Premium Vpn Kurulum Scripti${NC} ================="
echo -e "${BLUE}=================================================================${NC}"
echo -e ""
