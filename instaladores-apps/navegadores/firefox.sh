#!/bin/bash
## INSTALADOR DE FIREFOX
## INSTALABLE EN: arm64 x86_64 x86
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error() {
	echo "[ERROR] Algo malo ha ocurrido"
	echo
	echo "F"
	echo
	exit 1
}

function descargar() {
	if [[ $(lsb_release -si) == "Ubuntu" ]]; then
		if [ $(lsb_release -sr | cut -d"." -f1) -ge 22 ]; then
			sudo snap remove firefox
			sudo add-apt-repository ppa:mozillateam/ppa -y
			sudo mkdir -p /etc/apt/preferences.d/
			sudo cp "$ROOTDIR/aux-files/firefox/99mozilla" "/etc/apt/preferences.d/"
			sudo chmod 644 /etc/apt/preferences.d/99mozilla

			sudo apt-get update
			sudo apt-get -y -t 'o=LP-PPA-mozillateam' install firefox firefox-locale-es
		else
			sudo apt-get -y install firefox firefox-locale-es
		fi
	else
		case $(arch) in
			x86_64 | x86_64 | amd64) descargar_tar_x86_64 ;;
			i686 | i386) descargar_tar_i386 ;;
			*) esr_debian_otherarch ;;
		esac
	fi
}

function descargar_tar_x86_64() {
	sudo wget -O- "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=es-ES" | sudo tar xjf - -C /opt
	instalar_tar
}

function descargar_tar_i386() {
	sudo wget -O- "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux&lang=es-ES" | sudo tar xjf - -C /opt
	instalar_tar
}

function instalar_tar() {
	sudo chown -R $(whoami):$(whoami) /opt/firefox /opt/firefox/*
	sudo ln -s "/opt/firefox/firefox" "/usr/local/bin/firefox"
	sudo cp "$ROOTDIR/aux-files/firefox/firefox-linux.desktop" "/usr/share/applications/firefox-linux.desktop"
	sudo cp "$ROOTDIR/aux-files/firefox/firefox-uninstall.sh" "/opt/firefox/firefox-uninstall.sh"
	sudo chmod 755 /opt/firefox/firefox-uninstall.sh
	sudo apt-get -y install libdbus-glib-1-2
	for i in /opt/firefox/browser/chrome/icons; do
		SIZE=$(echo $i | rev | cut -d"." -f2 | cut -d"t" -f1 |rev)
		sudo cp "$i" "/usr/share/icons/hicolor/${SIZE}x${SIZE}/apps/firefox.png"
	done
	gtk-update-icon-cache /usr/share/icons/hicolor/.
}

function esr_debian_otherarch() {
	sudo apt-get install -y firefox-esr firefox-esr-locale-es-es
}

function desinstalar() {
	if [[ $(lsb_release -si) == "Ubuntu" ]]; then
		sudo apt-get -y autoremove --purge firefox firefox-locale-* xul-ext-ubufox
		if [ $(lsb_release -sr | cut -d"." -f1) -ge 22 ]; then
			sudo rm /etc/apt/preferences.d/mozillateamppa
			sudo apt-get update
		fi
	else
		case $(arch) in
		x86_64 | x86_64 | amd64) /opt/firefox/firefox-uninstall.sh ;;
		i686 | i386) /opt/firefox/firefox-uninstall.sh ;;
		*) sudo apt-get -y autoremove --purge firefox-esr firefox-esr-locale-* ;;
		esac
	fi
}

## LLAMADAS

if [[ "$1" != "-d" ]]; then
	descargar
else
	desinstalar
fi

exit 0
