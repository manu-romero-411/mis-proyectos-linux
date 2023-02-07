#!/bin/bash
## INSTALADOR DE NEOFETCH
## FECHA: 1 de enero de 2023

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
	sudo apt-get install -y neofetch
}

#check_root
instalador
exit 0
