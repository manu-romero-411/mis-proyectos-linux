#!/bin/bash
## INSTALADOR DE NEMO
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install --autoremove --purge nemo file-roller nemo-fileroller engrampa- xarchiver- || error
	instalador_nemodropbox
}

function instalador_nemodropbox(){
	TEMPO=$(mktemp)
	sudo apt-get install -y python3-gpg
	wget -O $TEMPO https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
	sudo dpkg -i $TEMPO
	sudo dpkg -i $ROOTDIR/files/nemo-dropbox_debian-buster-$(dpkg --print-architecture).deb
	sudo apt-get -f install -y
}

function config(){
	$ROOTDIR/tweaks/nemo-config.sh
}

## LLAMADAS

instalador

exit 0
