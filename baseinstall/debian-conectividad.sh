#!/bin/bash
## INSTALADOR DE COMPONENTES DE CONECTIVIDAD: REDES Y BLUETOOTH
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

	INSTALAR="network-manager network-manager-gnome net-tools blueman bluez"

	# ORDEN DE INSTALACIÓN
	apt-get -y install $INSTALAR
}

check_root
instalar
