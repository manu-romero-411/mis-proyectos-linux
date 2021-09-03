#!/bin/bash
## INSTALADOR DE VSCODIUM
## FECHA: 23 de septiembre de 2020

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
	sudo wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg 
	echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
#	touch ~/.inst
#}

#function inst(){
	sudo apt-get update
	sudo apt-get install -y codium || error No se ha podido instalar
#	rm ~/.inst
}
#check_root
#if [[ ! -f ~/.inst ]]; then
#	preinst
#fi
#inst
instalador

exit 0
