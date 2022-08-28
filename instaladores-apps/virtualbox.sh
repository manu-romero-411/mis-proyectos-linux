#!/bin/bash
## INSTALADOR DE VIRTUALBOX
## FECHA DE CREACIÓN: 25 de enero de 2021

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

function instalar(){
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | gpg --dearmor > /usr/share/keyrings/oracle_vbox_2016.gpg
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | gpg --dearmor > /usr/share/keyrings/oracle_vbox.gpg
	echo "deb [signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
	sudo apt-get update
	sudo apt-get install -y virtualbox-6.1
}

check_root
instalar
exit 0
