#!/bin/bash
## ARREGLANDO UN FALLO DE UBUNTU CON LA INTERFAZ ETHERNET AL REANUDAR EL PC DE UNA SUSPENSIÓN
## FECHA DE CREACIÓN: 7 de julio de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

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

function config(){
	sudo cp $ROOTDIR/files/r8169-refresh /lib/systemd/system-sleep/r8169-refresh
	sudo chmod 755 /lib/systemd/system-sleep/r8169-refresh
}

## LLAMADAS

#check_root
config

exit 0
