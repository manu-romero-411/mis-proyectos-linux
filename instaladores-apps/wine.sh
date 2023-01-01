#!/bin/bash
## SCRIPT DE INSTALACIÓN DE WINE STABLE EN UBUNTU Y DEBIAN
## FECHA DE CREACIÓN: 15 de febrero de 2020
## FECHAS DE MODIFICACIÓN: 5 de marzo de 2021

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error() {
	echo "[ERROR] $@. F"
	exit 1
}

function check_root() {
	if [[ $(whoami) != root ]]; then
		echo "[MALAMENTE] No eres root"
		error
	fi
}

function old() {

	## HAY QUE SOLUCIONAR UN INFIERNO DE DEPENDENCIAS QUE HAY EN UBUNTU 18.04

	if [[ $(lsb_release -sc) == "bionic" ]]; then
		sudo add-apt-repository -y ppa:cybermax-dexter/sdl2-backport || error
		sudo apt-get -y install libfaudio0 libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 || error

	## EN DEBIAN SE AÑADE OTRO REPOSITORIO ALOJADO EN OPENSUSE PARA SOLUCIONAR EL INFIERNO

	elif [[ $(lsb_release -si) == "Debian" ]] && [[ $(lsb_release -sc) == "buster" ]]; then
		sudo apt-key adv --fetch-keys https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key
		sudo su -c "echo 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/ ./' > /etc/apt/sources.list.d/faudio.list"
	fi

	## METEMOS EL REPOSITORIO DE WINE

	wget -q https://dl.winehq.org/wine-builds/winehq.key -O- | sudo apt-key add -
	version=$(lsb_release -sc)
	distributor=$(lsb_release -si)
	if [[ $distributor == "Debian" ]]; then
		sudo su -c "echo 'deb https://dl.winehq.org/wine-builds/debian/ $version main' > /etc/apt/sources.list.d/wine.list"
		sudo su -c "echo '#deb-src https://dl.winehq.org/wine-builds/debian/ $version main' >> /etc/apt/sources.list.d/wine.list"
	elif [[ $distributor == "Ubuntu" ]]; then
		sudo su -c "echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ $version main' > /etc/apt/sources.list.d/wine.list"
		sudo su -c "echo '#deb-src https://dl.winehq.org/wine-builds/ubuntu/ $version main' >> /etc/apt/sources.list.d/wine.list"
	fi
	sudo apt-get update || error
	sudo apt-get install -y --install-recommends wine-stable || error
}

function instalar() {
	## AÑADIENDO ARQUITECTURA INTEL 32 BITS

	sudo dpkg --add-architecture i386 || error
	sudo apt-get update || error

	## INSTRUCCIONES PARA UBUNTU PROCEDENTES DE https://wiki.winehq.org/Ubuntu
	if [ $(lsb_release -si) == "Ubuntu" ]; then
		UBUNTU_VERSION=$(lsb_release -sc)
		sudo wget -O /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
		sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$UBUNTU_VERSION/winehq-$UBUNTU_VERSION.sources
		sudo apt-get update
		sudo apt-get -y install winehq-stable
		DEBTEMP=$(mktemp)
		wget -O "$DEBTEMP" https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/w/wine-installer/wine-desktop-files_5.0.3_all.deb && sudo dpkg -i $DEBTEMP
		rm -f $DEBTEMP
	fi
}

function desinstalar() {
	sudo apt-get -y autoremove --purge winehq-stable
	sudo rm -f /usr/share/keyrings/winehq-archive.key
	sudo rm -f /etc/apt/sources.list.d/winehq-$UBUNTU_VERSION.sources
	sudo apt-get clean
}

## LLAMADAS

check_root
if [[ "$1" != "-d" ]]; then
	if [ "$(grep -Ei 'buntu' /etc/*release)" ]; then
		instalar
	fi
else
	desinstalar
fi

exit 0
