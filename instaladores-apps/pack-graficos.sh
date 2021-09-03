#!/bin/bash
## INSTALADOR DE APLICACIONES DE GRÁFICOS
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 11 de abril de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install --autoremove --purge kolourpaint gimp inkscape || error
	if ! echo lsb_release -si | grep "Mint"; then
		sudo apt-get -y install viewnior --autoremove --purge ristretto-
	fi
}

## LLAMADAS

instalador

exit 0
