#!/bin/bash
## INSTALADOR DE TLP
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

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
	sudo apt-get -y install tlp || error No se puede instalar
}

function config(){
	$ROOTDIR/tweaks/tlp-config.sh
}

## LLAMADAS

instalador
config

exit 0
