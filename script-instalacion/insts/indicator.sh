#!/bin/bash
## INSTALADOR DE INDICADORES
## FECHA DE CREACIÓN: 20 de mayo de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		error "No eres root"
	fi
}

function instalador(){
	if [[ "$XDG_CURRENT_DESKTOP" == "XFCE" ]]; then
		if [[ "$(lsb_release -si)" == "Ubuntu" ]]; then
			INSTALAR=indicator-applet-complete indicator-application --no-install-recommends
		elif [[ "$(lsb_release -si)" == "Debian" ]]; then
			INSTALAR=xfce4-indicator-plugin
		fi
		sudo apt-get -y install $INSTALAR || error Hubo un problema al instalar los paquetes
	fi
}

#check_root
instalador
exit 0
