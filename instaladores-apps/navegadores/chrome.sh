#!/bin/bash
## INSTALADOR DE CHROME
## FECHA DE CREACIÓN: 17 de mayo de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020, 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=com.google.Chrome
APT_PACKAGES="google-chrome-stable"

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
        if [[ $(whoami) != root ]]; then
                echo "[MALAMENTE] No eres root"
                error
        fi
}

function instalador(){
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | tee "/usr/share/keyrings/google-chrome.gpg" >/dev/null
	echo "deb [signed-by=/usr/share/keyrings/google-chrome.gpg arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee "/etc/apt/sources.list.d/google-chrome.list"
	apt-get update
	apt-get -y install --autoremove --purge $APT_PACKAGES || error Error al instalar
}

function flatpak_inst(){
	if ! dpkg --get-selections | grep flatpak; then
		$ROOTDIR/flatpak.sh
	fi
	flatpak install -y flathub $FLATPAK_ID
}

function desinstalar(){
	if dpkg --get-selections | grep flatpak; then
		flatpak uninstall -y $FLATPAK_ID
		flatpak uninstall -y --unused
	fi
	apt-get -y autoremove --purge $APT_PACKAGES
}

## LLAMADAS

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
elif [[ $1 == "-f" ]]; then
	flatpak_inst
else
	instalador
fi

exit 0
