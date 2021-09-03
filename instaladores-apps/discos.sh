#!/bin/bash
## INSTALADOR DE HERRAMIENTAS PARA TRABAJO CON DISCOS
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
	sudo apt-get install -y gnome-disk-utility gparted baobab smartmontools
}

#check_root
instalador
exit 0
