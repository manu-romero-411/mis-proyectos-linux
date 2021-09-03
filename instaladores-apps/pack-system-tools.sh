#!/bin/bash
## INSTALADOR DE LAS HERRAMIENTAS DEL SISTEMA DE GNOME Y XFCE
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020, 28 de octubre de 2020, 11 de abril de 2021

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	$ROOTDIR/insts/debian-backports.sh
	sudo apt-get -y install --autoremove --purge gnome-system-tools gnome-calculator gnome-font-viewer dconf-cli dconf-editor xdotool wmctrl libnotify-bin zenity yad seahorse dbus-x11 gvfs-backends net-tools mesa-utils || error
	if [[ $(lsb_release -si) == "Debian" ]] && ([[ $(lsb_release -sr) != "testing" ]] && [[ $(lsb_release -sr) != "sid" ]]); then
		BACKPORTS="-t $(lsb_release -sc)-backports"
	fi
	sudo apt-get -y $BACKPORTS install mugshot
}

## LLAMADAS

instalador

exit 0
