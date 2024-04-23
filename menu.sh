#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'

clear
echo -e ""
echo -e "${BLUE}=================================================================${NC}"
echo -e "${GREEN}=================================================================${NC}"
figlet EvoTeamMalaysia | lolcat
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}======================= ${RED}Menu SSH & OpenVPN ${BLUE}======================${NC}"
echo -e ""
echo -e "- add-ssh      : Create SSH & OpenVPN Account" | lolcat
echo -e "- trial-ssh    : Generate SSH & OpenVPN Trial Account" | lolcat
echo -e "- renew-ssh    : Extending SSH & OpenVPN Account Active Life" | lolcat
echo -e "- del-ssh      : Delete SSH & OpenVPN Account" | lolcat
echo -e "- cek-ssh      : Check User Login SSH & OpenVPN" | lolcat
echo -e "- list-ssh     : Daftar Member SSH & OpenVPN" | lolcat
echo -e "- delete       : Delete User Expired SSH & OpenVPN" | lolcat
echo -e "- autokill     : Set up Autokill SSH" | lolcat
echo -e "- mulog        : Displays Users Who Do Multi Login SSH" | lolcat
echo -e "- restart      : Restart Service Dropbear, Squid3, OpenVPN dan SSH" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}========================= ${RED}Menu Wireguard ${BLUE}========================${NC}"
echo -e ""
echo -e "- add-wg       : Create Wireguard Account" | lolcat
echo -e "- del-wg       : Delete Wireguard Account" | lolcat
echo -e "- cek-wg       : Check User Login Wireguard" | lolcat
echo -e "- renew-wg     : Extending Wireguard Account Active Life" | lolcat
echo -e "- wg show      : Check Wireguard User Interface" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}Menu L2TP ${BLUE}===========================${NC}"
echo -e ""
echo -e "- add-l2tp     : Creating L2TP Account" | lolcat
echo -e "- del-l2tp     : Deleting L2TP Account" | lolcat
echo -e "- renew-l2tp   : Extending L2TP Account Active Life" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}Menu PPTP ${BLUE}===========================${NC}"
echo -e ""
echo -e "- add-pptp     : Create Account PPTP" | lolcat
echo -e "- del-pptp     : Delete PPTP Account" | lolcat
echo -e "- renew-pptp   : Extending PPTP Account Active Life" | lolcat
echo -e "- cek-pptp     : Check User Login PPTP" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}Menu SSTP ${BLUE}===========================${NC}"
echo -e ""
echo -e "- add-sstp     : Create Account SSTP" | lolcat
echo -e "- del-sstp     : Delete SSTP Account" | lolcat
echo -e "- renew-sstp   : Extending SSTP Account Active Life" | lolcat
echo -e "- cek-sstp     : Check User Login SSTP" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}Menu SSR ${BLUE}============================${NC}"
echo -e ""
echo -e "- add-ssr      : Create SSR Account" | lolcat
echo -e "- del-ssr      : Deleting SSR Account" | lolcat
echo -e "- renew-ssr    : Extending SSR Account Active Life" | lolcat
echo -e "- ssr          : Show Other SSR Menu" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}======================== ${RED}Shadowsocks OBFS ${BLUE}=======================${NC}"
echo -e ""
echo -e "- add-ss       : Creating Shadowsocks Account" | lolcat
echo -e "- del-ss       : Delete Shadowsocks Account" | lolcat
echo -e "- renew-ss     : Extending Shadowsocks Account Active Life" | lolcat
echo -e "- cek-ss       : Check User Login Shadowsocks" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}Menu VMESS ${BLUE}==========================${NC}"
echo -e ""
echo -e "- add-ws       : Create V2ray Vmess WS Account" | lolcat
echo -e "- del-ws       : Deleting V2ray Vmess WS Account" | lolcat
echo -e "- renew-ws     : Extending Vmess Account Active Life" | lolcat
echo -e "- cek-ws       : Check User Login V2ray" | lolcat
echo -e "- cert2vray    : Renew Certificate V2ray Account" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}=========================== ${RED}Menu VLESS ${BLUE}==========================${NC}"
echo -e ""
echo -e "- add-vless    : Create V2ray Vless WS Account" | lolcat
echo -e "- del-vless    : Deleting V2ray Vless WS Account" | lolcat
echo -e "- renew-vless  : Extending Vless Account Active Life" | lolcat
echo -e "- cek-vless    : Check User Login V2ray" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}========================== ${RED}Menu Trojan ${BLUE}==========================${NC}"
echo -e ""
echo -e "- add-tr       : Create Trojan Account" | lolcat
echo -e "- del-tr       : Deleting Trojan Account" | lolcat
echo -e "- renew-tr     : Extending Trojan Account Active Life" | lolcat
echo -e "- cek-tr       : Check User Login Trojan" | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "${BLUE}========================== ${RED}Menu SYSTEM ${BLUE}==========================${NC}"
echo -e ""
echo -e "- auto-reboot  : Set Auto Reboot VPS" | lolcat
echo -e "- change-port  : Change Port Of Some Service" | lolcat
echo -e "- autobackup   : Autobackup Data VPS" | lolcat
echo -e "- backup       : Backup Data VPS" | lolcat
echo -e "- restore      : Restore Data VPS" | lolcat
echo -e "- webmin       : Webmin Menu" | lolcat
echo -e "- kernel-up    : Update To Latest Kernel" | lolcat
echo -e "- vnstat       : Check Usage Bandwith Server" | lolcat
echo -e "- speed-limiter: Limit Bandwith Speed Server" | lolcat
echo -e "- ram          : Check Usage of VPS Ram" | lolcat
echo -e "- reboot       : Reboot VPS" | lolcat
echo -e "- speedtest    : Speedtest VPS" | lolcat
echo -e "- update       : Update To Latest Script Version" | lolcat
echo -e "- info         : Displaying System Information" | lolcat
echo -e "- about        : Info Script Auto Install" | lolcat
echo -e "- exit         : Exit From Terminal VPS " | lolcat
echo -e ""
echo -e "${GREEN}=================================================================${NC}"
echo -e "===================== ${RED}AutoScript By EvoTeamMalaysia${NC} ================="
echo -e "${BLUE}=================================================================${NC}"
echo -e ""
