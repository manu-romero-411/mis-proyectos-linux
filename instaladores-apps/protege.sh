#!/bin/bash
## INSTALADOR DE PROTEGE
## FECHA DE CREACIÓN: 14 de junio de 2023

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
PROTEPATH="/opt/protege"

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

function desinstalar() {
	rm -r /home/"$SUDO_USER"/*/*rot*g* /home/"$SUDO_USER"/.local/share/applications/protege.desktop "$PROTEPATH"
}

function deb_download(){
    LINK="https://api.github.com/repos/protegeproject/protege-distribution/releases/latest"
    GUNZ="/tmp/protegetemp.tar"
    DEBTEMP="${GUNZ}.gz"

    mkdir "$PROTEPATH"
    chown -R ${SUDO_USER}:${SUDO_USER} "$PROTEPATH"
    cd $(dirname "$DEBTEMP")
    curl -s $LINK |
        grep "browser_download_url.*tar.gz" |
        cut -d : -f 2,3 |
        tr -d \" |
        wget -O "$DEBTEMP" -i -
    gunzip "$DEBTEMP"
    tar xvf "${GUNZ}" -C "$PROTEPATH"
    mv "$PROTEPATH"/Protege-*/* "$PROTEPATH"
    rm -r "$PROTEPATH"/Protege-*
    rm -f "$DEBTEMP" "${GUNZ}"
    cat  > "/home/$SUDO_USER/.local/share/applications/protege.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Protégé
Comment=Herramienta de trabajo con ontologías
Exec="$PROTEPATH/protege"
Icon=protege
Path=
Terminal=false
StartupNotify=true
Categories=Development;Office;
EOF
    chown -R $SUDO_USER:$SUDO_USER "/home/$SUDO_USER/.local/share/applications/protege.desktop"
    mkdir -p "/home/$SUDO_USER/.icons/app-icons"
}

## LLAMADAS

check_root
if [[ "$1" != "-d" ]]; then
	deb_download
else
	desinstalar
fi

exit 0
