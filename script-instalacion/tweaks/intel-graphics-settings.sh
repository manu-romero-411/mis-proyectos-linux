#!/bin/bash
## CONFIGURAR GRÁFICA INTEL
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN: 7 de octubre de 2020, 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/../)

## FUNCIONES PRELIMINARES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function root_checker(){
	if [[ $(id -u) != 0 ]]; then
		error No se puede ejecutar el script porque no se cuentan con privilegios de administrador
	fi
}

function config(){
	sudo cp "$ROOTDIR/files/20-intel.conf" "/usr/share/X11/xorg.conf.d/20-intel.conf"
}

#root_checker
config

exit 0
