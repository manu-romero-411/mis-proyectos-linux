#!/bin/bash
## INSTALADOR DE SUBLIME TEXT
## FECHA: 20 de mayo de 2020

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
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - || error
	apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
	apt-get update || error
	apt-get install -y sublime-text || error
}

check_root
instalador
exit 0
