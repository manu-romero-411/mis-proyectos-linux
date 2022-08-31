#!/bin/bash
## INSTALADOR DE MATE EN DEBIAN
## FECHA: 31 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
INSTALAR="task-mate-desktop"

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
	apt-get -y install --autoremove --purge $INSTALAR
}

function desinstalar()
	apt-get -y autoremove --purge $INSTALAR
}

check_root
instalar
