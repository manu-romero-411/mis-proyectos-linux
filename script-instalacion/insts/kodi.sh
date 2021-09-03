#!/bin/bash
## INSTALADOR DE KODI
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] Ha ocurrido un error."
	exit 1
}

function dependencias(){
	sudo apt-get -y install fonts-noto-hinted \
	fonts-roboto-hinted \
	libcec4 \
	libcrossguid0 \
	libjs-iscroll \
	liblzo2-2 \
	libmicrohttpd12 \
	libp8-platform2 \
	libpcrecpp0v5 \
	libtinyxml2.6.2v5 \
	python-olefile \
	python-pil \
	i965-va-driver \
	vdpau-va-driver \
	libvdpau-va-gl1 \
	libiso9660-11 \
	libfstrcmp0 \
	libvdpau1
}

function ppa(){
	sudo add-apt-repository -y ppa:team-xbmc/ppa
	sudo apt update
}

function instalador_apt(){
	sudo apt-get -y install kodi
}

## LLAMADAS

if [[ -z $1 ]]; then
	if lsb_release -sd | grep Mint || lsb_release -sd | grep Ubuntu; then
		ppa
	fi
	instalador_apt
else
	$1 || error
fi

exit 0


