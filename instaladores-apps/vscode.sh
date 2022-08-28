#!/bin/bash
## INSTALADOR DE VISUAL STUDIO CODE
## FECHA: 6 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=com.visualstudio.code
APT_PACKAGES="code"

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
        ARQ=$(arch)
        case $ARQ in
                amd64|x86_64|x86-64) ARQ1=amd64;;
                aarch64|armv8|arm64) ARQ1=arm64;;
                armv7|armhf) ARQ1=armhf;;
        esac
        sudo apt-get install -y apt-transport-https

        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "/tmp/vscode.gpg"
        install -o root -g root -m 644 "/tmp/vscode.gpg" "/usr/share/keyrings/"
        echo "deb [arch=$ARQ1 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/code stable main" | tee "/etc/apt/sources.list.d/vscode.list"
        rm "/tmp/vscode.gpg"

        sudo apt-get update
        sudo apt-get install -y $APT_PACKAGES || error
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
	rm "/usr/share/keyrings/vscode.gpg" "/etc/apt/sources.list.d/vscode.list"
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
