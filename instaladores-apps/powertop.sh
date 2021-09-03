#!/bin/bash
## INSTALADOR DE POWERTOP
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $1. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install --autoremove --purge powertop || error
}

function config(){
	sudo $ROOTDIR/tweaks/powertop.sh
}

## LLAMADAS

instalador

exit 0
