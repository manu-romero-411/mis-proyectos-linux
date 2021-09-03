#!/bin/bash
## INSTALADOR DE SPOTIFY
## FECHA DE CREACIÓN: 6 de octubre de 2020
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

function instalador(){
#function preinst(){
	sudo apt-get install -y curl
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D1742AD60D811D58
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
#	touch ~/.inst
#}

#function inst(){
	sudo apt update
	sudo apt install -y spotify-client || error
#	rm ~/.inst
}
#check_root
#if [[ ! -f ~/.inst ]]; then
#	preinst
#fi
instalador

exit 0
