#!/bin/bash
## INSTALADOR DE APLICACIONES DE OFICINA
## FECHA DE CREACIÓN: 1 de enero de 2023
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	if [[ $(lsb_release -si) == "Debian" ]]; then
		$ROOTDIR/debian-backports.sh
		BACKPORTS="-t $(lsb_release -sc)-backports"
	else
		BACKPORTS=
	fi
	sudo apt-get -y install --autoremove --purge $BACKPORTS libreoffice libreoffice-l10n-es libreoffice-gtk3 myspell-es hunspell || error
}

function desinstalar(){
	sudo apt-get -y autoremove --purge libreoffice libreoffice-l10n-es libreoffice-gtk3 hunspell myspell-es
}

## LLAMADAS

if [[ "$1" == "-d" ]];then
	desinstalar
else
	instalador
fi
exit 0
