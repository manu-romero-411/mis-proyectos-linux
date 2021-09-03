#!/bin/bash
## ARREGLANDO UN FALLO DE UBUNTU CON LA INTERFAZ ETHERNET AL REANUDAR EL PC DE UNA SUSPENSIÓN
## FECHA DE CREACIÓN: 7 de julio de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020, 3 de septiembre de 2021

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] Algo malo ha ocurrido"
	echo
	echo "F"
	echo
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		echo "[MALAMENTE] No eres root"
		error
	fi
}

function config(){
	sudo su -c '#!/bin/bash

PROGNAME=$(basename "$0")
state=$1
action=$2

function log {
    logger -i -t "$PROGNAME" "$*"
}

log "Running $action $state"

if [[ $state == post ]]; then
    modprobe -r r8169 \\
    && log "Removed r8169" \\
    && modprobe -i r8169 \\
    && log "Inserted r8169"
fi' /lib/systemd/system-sleep/r8169-refresh
	sudo chmod 755 /lib/systemd/system-sleep/r8169-refresh
}

## LLAMADAS

#check_root
config

exit 0
