#!/bin/bash
## INSTALADOR DE CHROMIUM
## FECHA DE CREACIÓN: 5 de junio de 2021

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		error "[MALAMENTE] No eres root"
	fi
}

if [[ $(lsb_release -si) != "Ubuntu" ]]; then
	sudo apt-get install -y chromium chromium-l10n
else
	error "En Ubuntu no se puede instalar Chromium como .deb, sino como snap"
fi
exit 0
