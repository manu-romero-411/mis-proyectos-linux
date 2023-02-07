#!/bin/bash
## INSTALADOR DE MICROSOFT EDGE
## FECHA DE CREACIÓN: 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
APT_PACKAGES="microsoft-edge-stable"

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
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "/tmp/msedge.gpg"
	install -o root -g root -m 644 "/tmp/msedge.gpg" "/usr/share/keyrings/"
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/msedge.gpg] https://packages.microsoft.com/repos/edge stable main" | tee "/etc/apt/sources.list.d/microsoft-edge.list"
	rm "/tmp/msedge.gpg"
	apt-get update
	apt-get -y install $APT_PACKAGES
}

function desinstalar(){
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
