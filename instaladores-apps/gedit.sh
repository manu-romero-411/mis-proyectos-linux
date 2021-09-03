#!/bin/bash
## INSTALADOR DE GEDIT
## FECHA DE CREACIÓN:7 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install --autoremove --purge gedit gedit-plugins mousepad- || error
}

function config(){
	$ROOTDIR/tweaks/gedit-config.sh
}

## LLAMADAS

#check_root
instalador
config

exit 0
