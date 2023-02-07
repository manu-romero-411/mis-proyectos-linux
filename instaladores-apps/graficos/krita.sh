#!/bin/bash
## INSTALADOR DE KRITA
## FECHA DE CREACIÓN: 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=org.kde.krita
APT_PACKAGES="krita"

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
	$ROOTDIR/../tweaks-y-workarounds/qt.sh
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
elif [[ $1 == "-nf" ]]; then
	instalador
else
	flatpak_inst
fi

exit 0
