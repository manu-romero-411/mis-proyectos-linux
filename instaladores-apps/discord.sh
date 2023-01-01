#!/bin/bash
## INSTALADOR DE DISCORD
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=com.discordapp.Discord

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

function descargar_debian(){
	DISCORDDEB="$(mktemp)"
	if dpkg --get-selections | grep discord > /dev/null; then
		error Ya está instalado
	fi
	wget -O "$DISCORDDEB" 'https://discord.com/api/download?platform=linux&format=deb' && sudo dpkg -i "$DISCORDDEB"
	sudo apt-get -f -y install
	rm -f "$DISCORDDEB"
}

function flatpak_ins(){
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

    rm -r /home/$(id -nu 1000)/.config/discord
	apt-get -y autoremove --purge discord
}

## LLAMADAS

check_root
if [[ "$1" != "-d" ]]; then
	if [[ "$1" == "-f" ]]; then
		flatpak_ins
	else
		if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
			descargar_debian
		fi
	fi
else
    desinstalar
fi

exit 0
