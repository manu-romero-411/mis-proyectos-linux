#!/bin/bash
## INSTALADOR DE DEVKITPRO
## FECHA: 2 de enero de 2023

ROOTDIR="$(realpath $(dirname $0))"

function error() {
	echo "[ERROR] $@. F"
	exit 1
}

function check_root() {
	if [[ $(whoami) != root ]]; then
		echo "[MALAMENTE] No eres root"
		error
	fi
}

function instalador() {
## DEVKITPRO (dependencia previa)
	"$ROOTDIR/devkitpro.sh"
	which dkp-pacman && dkp-pacman -Syu 3ds-dev --noconfirm
	CTR_URL="https://api.github.com/repos/3DSGuy/Project_CTR/releases"

## MAKEROM
	ZIPTEMP1="$(mktemp)"
	curl -s "$CTR_URL" |
	grep makerom |
	grep browser_download_url |
	grep ubuntu |
	head -n 1 |
	cut -d : -f 2,3 |
	tr -d \" |
	cut -d " " -f 2 |
	wget -O "$ZIPTEMP1" -i - && unzip -d /opt/devkitpro/tools/bin/ "$ZIPTEMP1"
	chmod 755 /opt/devkitpro/tools/bin/makerom
	rm "$ZIPTEMP1"
## CTR
        ZIPTEMP2="$(mktemp)"
        curl -s "$CTR_URL" |
        grep ctrtool |
        grep browser_download_url |
        grep ubuntu |
        head -n 1 |
        cut -d : -f 2,3 |
        tr -d \" |
        cut -d " " -f 2 |
        wget -O "$ZIPTEMP2" -i - && unzip -d /opt/devkitpro/tools/bin/ "$ZIPTEMP2"
        chmod 755 /opt/devkitpro/tools/bin/ctrtool
	rm "$ZIPTEMP2"
}

function desinstalar() {
	sudo apt-get -y autoremove --purge devkitpro-pacman
	sudo rm /usr/share/keyrings/devkitpro-pub.gpg
	sudo rm /etc/apt/sources.list.d/devkitpro.list
}

check_root
if [[ "$1" == "-d" ]]; then
	desinstalar
else
	instalador
fi
exit 0
