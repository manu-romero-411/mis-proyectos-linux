#!/bin/bash
## INSTALADOR DE CHROMIUM
## FECHA DE CREACIÓN: 5  de junio de 2021

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		error "[MALAMENTE] No eres root"
	fi
}

function instalar(){
	sudo apt-get install -y chromium chromium-l10n
	exit 0
}
