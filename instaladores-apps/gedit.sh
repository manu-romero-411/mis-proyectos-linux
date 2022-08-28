#!/bin/bash
## INSTALADOR DE GEDIT
## FECHA DE CREACIÓN:7 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install --autoremove --purge gedit gedit-plugins mousepad- || error Error al instalar
}

function config(){
	sudo apt-get -y install dconf-cli
	cat "$ROOTDIR/post-install-configs/gedit/gedit-config.ini" | dconf load /org/gnome/gedit/
	cat "$ROOTDIR/post-install-configs/gedit/gedit-root-config.ini" | sudo dconf load /org/gnome/gedit/
}

## LLAMADAS

#check_root
instalador
config

exit 0
