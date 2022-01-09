#!/bin/bash
## INSTALADOR DE CHROME
## FECHA DE CREACIÓN: 9 de enero de 2022
## FECHAS DE MODIFICACIÓN:

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

#check_root
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list'
sudo apt-get update
sudo apt-get install -y anydesk
exit 0
