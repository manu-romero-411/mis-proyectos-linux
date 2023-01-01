#!/bin/bash
## INSTALADOR DE DISCORD
## FECHA DE CREACIÓN: 31 de diciembre de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=md.Obsidian.obsidian

## FUNCIONES

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

function flatpak_ins() {
    if ! dpkg --get-selections | grep flatpak; then
        $ROOTDIR/flatpak.sh
    fi
    flatpak install -y flathub $FLATPAK_ID
}

function desinstalar() {
    if dpkg --get-selections | grep flatpak; then
        flatpak uninstall -y $FLATPAK_ID
        flatpak uninstall -y --unused
    fi

    apt-get -y autoremove --purge obsidian
}

function deb_download(){
    LINK="https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest"
    DEBTEMP=$(mktemp)

    curl -s $LINK |
        grep "browser_download_url.*deb" |
        cut -d : -f 2,3 |
        tr -d \" |
        wget -O "$DEBTEMP" -i - && sudo dpkg -i $DEBTEMP

    rm -f $DEBTEMP
}

## LLAMADAS

check_root
if [[ "$1" != "-d" ]]; then
	if [[ "$1" == "-f" ]]; then
		flatpak_ins
	else
		if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
			deb_download
		fi
	fi
else
    desinstalar
fi

exit 0