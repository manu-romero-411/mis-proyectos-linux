#!/bin/bash
## INSTALADOR DE LXDE EN DEBIAN
## FECHA: 31 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
INSTALAR="lxsession lxpanel openbox pcmanfm gvfs gvfs-backends file-roller lxterminal desktop-base xfce4-power-manager xfce4-power-manager-plugins xfce4-notifyd lxpolkit"

## FUNCIONES

function error(){
        echo "[ERROR] $1. F"
        exit 1
}

function check_root(){
        if [[ $(whoami) != root ]]; then
                echo "[MALAMENTE] No eres root"
                error
        fi
}

function instalar(){

	# ORDEN DE INSTALACIÓN
	apt-get -y install --no-install-recommends --autoremove --purge $INSTALAR
}

function desinstalar()
	apt-get -y autoremove --purge $INSTALAR
}

check_root
instalar
