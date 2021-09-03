#!/bin/bash
## SCRIPT DE INSTALACIÓN DE LUTRIS EN DEBIAN
## FECHA DE CREACIÓN: 24 de junio de 2020
## FECHAS DE MODIFICACIÓN:

function error(){
	echo "[ERROR] Algo ha ocurrido. F."
	exit 1
}

function root(){
	if [[ $(whoami) != "root" ]]; then
		echo "TOONTO, QUE ERES TOONTO, TOONTO, PERO NO PA UN RATO, NO, TONTO DEL TOO, PA SIEMPRE" 
		echo "VAYA UN MUGROSO HARTOSOPAS QUE NO ES ROOT"
		error
	fi
}

## AÑADIMOS SOPORTE 32 BITS EN DPKG

sudo dpkg --add-architecture i386 || error

## AÑADIMOS REPOS

echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
sudo apt-get update

## INSTALAMOS

sudo apt-get -y install lutris



