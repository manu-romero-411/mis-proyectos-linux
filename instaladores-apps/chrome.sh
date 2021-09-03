#!/bin/bash
## INSTALADOR DE CHROME
## FECHA DE CREACIÓN: 17 de mayo de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020,

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
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add 
sudo sh -c "echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list"
sudo apt-get update
sudo apt-get install -y google-chrome-stable
exit 0
