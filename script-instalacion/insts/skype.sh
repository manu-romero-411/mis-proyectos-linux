#!/bin/bash
## INSTALADOR DE SKYPE
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	(SKYPEDEB="$(mktemp)" &&
	wget -O $SKYPEDEB https://go.skype.com/skypeforlinux-64.deb &&
	sudo dpkg -i "$SKYPEDEB" &&
	sudo apt-get -f -y install &&
	rm -f "$SKYPEDEB") || error Ha ocurrido algo
}

function desinstalar(){
	sudo apt-get -y autoremove --purge skypeforlinux || error No se ha podido desinstalar
}

#function config(){
#}

## LLAMADAS

if [[ "$1" != "-d" ]]; then
	instalador
	#config
else
	desinstalar
fi
exit 0
