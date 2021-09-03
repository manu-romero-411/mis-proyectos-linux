#!/bin/bash
## CONFIGURADOR DE GEDIT
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHA DE MODIFICACIÓN: 

ROOTDIR=$(realpath $(dirname $0)/../)

function config(){
if [[ "$(whoami)" != "root" ]]; then
	cat "$ROOTDIR/files/gedit-config.ini" | dconf load /org/gnome/gedit/
else
	cat "$ROOTDIR/files/gedit-root-config.ini" | dconf load /org/gnome/gedit/
fi
}

config
exit 0
