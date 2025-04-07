# onvao.net Hepsibiraradavpn

## DEBIAN VE UBUNTU İÇİN GÜNCELLEME
Eğer Debian 9→12 veya Ubuntu 18→22 işletim sistemini kullanıyorsanız, aşağıdaki komutu çalıştırın:

```
apt update && apt upgrade -y && update-grub && sleep 2 && reboot
```

## SCRIPT KURULUMU
Aşağıdaki komutu çalıştırarak Ե onvao.net Զ tarafından hazırlanan Ovpn Script'ini yükleyebilirsiniz:

```
apt install -y && apt update -y && apt upgrade -y && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && wget https://raw.githubusercontent.com/muzaffer72/hepsibiraravpn/refs/heads/main/install.sh; bash install.sh
```

## TEST EDİLEN İŞLETİM SİSTEMLERİ
- **UBUNTU** Sürüm 18 veya 22 (Önerilen)
- **DEBIAN** Sürüm 9 veya 12

