#!/bin/bash
## INSTALADOR DE SYNAPTIC Y GDEBI
## FECHA: 24 de junio de 2020

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

function instalador(){
	sudo apt-get -y install synaptic gdebi || error
}

#check_root
instalador
exit 0
