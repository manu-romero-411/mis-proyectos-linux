#!/bin/bash
## INSTALADOR DE SERVIDOR GRÁFICO X EN DEBIAN, Y LIGHTDM
## FECHA: 31 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

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

	# SERVIDOR X
	INSTALAR="xserver-xorg-core xinit xorg xserver-xorg-input-libinput xserver-xorg-input-all xserver-xorg-input-kbd"
        if [[ $(arch) == "amd64" ]] || [[ $(arch) == "i386" ]] || [[ $(arch) == "i686" ]]; then
                INSTALAR="$INSTALAR xserver-xorg-video-intel xserver-xorg-input-synaptics"
        fi

	# LIGHTDM
	INSTALAR="$INSTALAR lightdm lightdm-settings slick-greeter"

	# ORDEN DE INSTALACIÓN
	apt-get -y install $INSTALAR
}

check_root
instalar
