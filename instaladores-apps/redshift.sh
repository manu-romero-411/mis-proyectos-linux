#!/bin/bash
## INSTALADOR DE REDSHIFT
## FECHA DE CREACIÓN: 24 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install redshift redshift-gtk || error
}

function desinstalar(){
	sudo apt-get -y autoremove --purge redshift redshift-gtk || error
}

## LLAMADAS

if [[ "$1" != "-d" ]]; then
	instalador
else
	desinstalar
fi
exit 0
