#!/bin/bash
## INSTALADOR DE KDE PLASMA EN DEBIAN
## FECHA: 31 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
INSTALAR="desktop-base plasma-desktop"

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
	apt-get -y install $INSTALAR
}

function desinstalar()
	apt-get -y autoremove --purge $INSTALAR
}

check_root
instalar
