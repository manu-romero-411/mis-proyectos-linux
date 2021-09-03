#!/bin/bash
## INSTALADOR DE APLICACIONES MULTIMEDIA
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
	sudo apt-get -y install --autoremove --purge vlc rhythmbox cheese pavucontrol timidity soundconverter parole- exfalso- quodlibet- || error
}

function instaladorAppsAvanzadas(){
	sudo apt-get -y install kdenlive openshot audacity
}

## LLAMADAS

if [ ! -z $@ ]; then
	$1 || error Función errónea
else
	instalador
fi

exit 0
