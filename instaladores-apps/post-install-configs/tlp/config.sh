#!/bin/bash
## CONFIGURADOR DE TLP
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

function config(){

	# AJUSTAR FICHERO DE CONFIG A VERSIONES NUEVAS DE TLP
	if [[ ! -f /etc/tlp.conf ]]; then
		sudo ln -s /etc/default/tlp /etc/tlp.conf
	fi

	# QUITAR TURBO BOOST
	sudo sed -i s/"#CPU_BOOST_ON_AC=1"/"CPU_BOOST_ON_AC=0"/g /etc/tlp.conf || error Ha ocurrido algo
	sudo sed -i s/"#CPU_BOOST_ON_BAT=0"/"CPU_BOOST_ON_BAT=0"/g /etc/tlp.conf || error Ha ocurrido algo

	# DESHABILITAR BLUETOOTH AL INICIO
	sudo sed -i s/\#DEVICES_TO_DISABLE_ON_STARTUP=\"bluetooth\ wifi\ wwan\"/DEVICES_TO_DISABLE_ON_STARTUP=\"bluetooth\"/g /etc/tlp.conf || Ha ocurrido algo
}

#check_root
config

exit 0
