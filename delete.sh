#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "VPS Kontrol Ediliyor"
 
clear
               hariini=`date +%d-%m-%Y`
               echo "SÜRESİ DOLMUŞ KULLANICILARI SİLDİĞİNİZ İÇİN TEŞEKKÜR EDERİZ"
               echo "--------------------------------------"
               cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
               totalaccounts=`cat /tmp/expirelist.txt | wc -l`
               for((i=1; i<=$totalaccounts; i++ ))
               do
               tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
               username=`echo $tuserval | cut -f1 -d:`
               userexp=`echo $tuserval | cut -f2 -d:`
               userexpireinseconds=$(( $userexp * 86400 ))
               tglexp=`date -d @$userexpireinseconds`             
               tgl=`echo $tglexp |awk -F" " '{print $3}'`
               while [ ${#tgl} -lt 2 ]
               do
               tgl="0"$tgl
               done
               while [ ${#username} -lt 15 ]
               do
               username=$username" " 
               done
               bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
               echo "echo "Süresi Dolmuş- Kullanıcı : $username Süresi Bitti : $tgl $bulantahun"" >> /usr/local/bin/alluser
               todaystime=`date +%s`
               if [ $userexpireinseconds -ge $todaystime ] ;
               then
		    	:
               else
               echo "echo "Süresi Dolmuş- Kullanıcı Adı : $username, $tgl $bulantahun tarihinde süresi dolmuş ve silindi : $hariini "" >> /usr/local/bin/deleteduser
	           echo "Kullanıcı Adı $username, $tgl $bulantahun tarihinde süresi dolmuş ve $hariini tarihinde VPS'den silindi"
               userdel $username
               fi
               done
               echo " "
               echo "======================================"
               echo "Script başarıyla çalıştırıldı"
