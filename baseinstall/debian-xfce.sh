#!/bin/bash
## INSTALADOR DE XFCE EN DEBIAN
## FECHA: 31 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
INSTALAR="xfwm4 xfce4-terminal xfce4-panel xfce4-session xfdesktop4 desktop-base gvfs gvfs-backends"

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

	if [[ "$1" == "-n" ]] || [[ "$1" == "--xfce4-nemo" ]]; then
		INSTALAR="$INSTALAR nemo file-roller nemo-fileroller"
	else
		INSTALAR="$INSTALAR thunar thunar-archive-plugin thunar-media-tags-plugin engrampa"
	fi

	# ORDEN DE INSTALACIÓN
	apt-get -y install --no-install-recommends --autoremove --purge $INSTALAR
}

function desinstalar()
	apt-get -y autoremove --purge xfce4-* xfwm4 thunar* nemo*
}

check_root
instalar $1
