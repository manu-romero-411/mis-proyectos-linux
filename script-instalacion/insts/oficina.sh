#!/bin/bash
## INSTALADOR DE APLICACIONES DE GRÁFICOS
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

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

function instalador(){
	if [[ $(lsb_release -si) == "Debian" ]]; then
		$ROOTDIR/insts/debian-backports.sh
		BACKPORTS="-t $(lsb_release -sc)-backports"
	else
		BACKPORTS=
	fi
	sudo apt-get -y install --autoremove --purge $BACKPORTS libreoffice libreoffice-l10n-es libreoffice-gtk3 myspell-es hunspell atril || error
}

## LLAMADAS

instalador

exit 0
