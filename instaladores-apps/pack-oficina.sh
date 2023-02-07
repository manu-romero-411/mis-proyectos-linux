#!/bin/bash
## INSTALADOR DE APLICACIONES DE OFICINA
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	"$ROOTDIR/libreoffice.sh"
	sudo apt-get -y install --autoremove --purge atril || error
}

## LLAMADAS

instalador

exit 0
