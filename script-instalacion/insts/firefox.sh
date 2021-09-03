#!/bin/bash
## INSTALADOR DE FIREFOX
## FECHA DE CREACIÓN: 23 de octubre de 2020
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

function descargar(){
	if [[ $(lsb_release -si) == "Ubuntu" ]]; then
		sudo apt-get -y install firefox firefox-locale-es-es ## ESTO SEGURAMENTE HABRÁ QUE CORREGIRLO
	else ## paso de instalar Firefox ESR en Debian
		if [[ $(arch) == "x86_64" ]] || [[ $(arch) == "x86-64" ]] || [[ $(arch) == "amd64" ]]; then
			sudo wget -O- "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=es-ES" | sudo tar xjf - -C /opt
		elif [[ $(arch) == "i686" ]] || [[ $(arch) == "i386" ]]; then
        		sudo wget -O- "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux&lang=es-ES" | sudo tar xjf - -C /opt
        	fi
        	sudo chown -R $(whoami):$(whoami) /opt/firefox /opt/firefox/*
		sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
		sudo su -c "echo 'cd /
sudo rm /usr/share/applications/firefox-linux.desktop
rm -r $HOME/.mozilla
sudo rm /usr/local/bin/firefox
sudo rm -r /opt/firefox' > /opt/firefox/firefox-uninstall.sh"
		sudo chmod 755 /opt/firefox/firefox-uninstall.sh
		debian_iconoMenu
	fi
}

function debian_iconoMenu(){
        #cp $ROOTDIR/files/discord.desktop $HOME/.local/share/applications/discord.desktop
        sudo cp $ROOTDIR/files/firefox.desktop /usr/share/applications/firefox-linux.desktop
}

function desinstalar(){
	if [[ $(lsb_release -si) == "Ubuntu" ]]; then
		sudo apt-get -y autoremove --purge firefox firefox-locale-* xul-ext-ubufox
	else
		sudo rm /usr/share/applications/firefox-linux.desktop
        	rm -r $HOME/.mozilla
		sudo rm /usr/local/bin/firefox
        	sudo rm -r /opt/firefox
	fi
}

## LLAMADAS

if [[ "$1" != "-d" ]]; then
    descargar
else
    desinstalar
fi

exit 0
