#!/bin/bash
## INSTALADOR DE VISUAL STUDIO CODE
## FECHA: 6 de octubre de 2020

function error(){
	echo "[ERROR] Algo malo ha ocurrido"
	echo
	echo "F"
	echo
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		echo "[MALAMENTE] No eres root"
		error
	fi
}

function instalador(){
	sudo apt-get install -y apt-transport-https

	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
	sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm /tmp/packages.microsoft.gpg

	sudo apt-get update
	sudo apt-get install -y code || error
}
instalador

exit 0
