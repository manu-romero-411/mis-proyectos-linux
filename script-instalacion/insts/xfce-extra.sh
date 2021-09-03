#!/bin/bash
## INSTALADOR DE COMPONENTES BÁSICOS DE XFCE (NO TAN BÁSICOS COMO LOS DEL SCRIPT PRINCIPAL
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

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
	sudo apt-get -y install libxfce4ui-utils catfish xfce4-taskmanager xfce4-appfinder xfce4-whiskermenu-plugin xfce4-places-plugin xfce4-screenshooter xfce4-power-manager xfce4-notifyd xfce4-pulseaudio-plugin || error No se han podido instalar los paquetes
}

#check_root
instalador
exit 0
