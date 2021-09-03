#!/bin/bash
## INSTALADOR DE VIRTUALBOX
## FECHA DE CREACIÓN: 25 de enero de 2021

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

#check_root
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c "echo 'deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib' > /etc/apt/sources.list.d/virtualbox.list"
sudo apt-get update
sudo apt-get install -y virtualbox-6.1
exit 0
