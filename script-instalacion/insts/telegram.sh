#!/bin/bash
## INSTALADOR DE TELEGRAM
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
        echo "[ERROR] $@. F"
        exit 1
}

function descargar(){
	wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
        sudo chown -R $(whoami):$(whoami) /opt/Telegram /opt/Telegram/*
	sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram
	sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
	echo "cd /
rm $HOME/.local/share/applications/appimagekit_*-Telegram_Desktop.desktop
rm $HOME/.local/share/applications/telegram*.desktop
rm -r $HOME/.local/share/TelegramDesktop
sudo rm /etc/skel/.local/share/applications/telegram.desktop
sudo rm /usr/local/bin/telegram
sudo rm /usr/local/bin/telegram-desktop
sudo rm -r /opt/Telegram" > /opt/Telegram/telegram-uninstall.sh
	chmod 755 /opt/Telegram/telegram-uninstall.sh
}

function iconoMenu(){
	[[ ! -d "$HOME/.local" ]] && mkdir "$HOME/.local"
	[[ ! -d "$HOME/.local/share" ]] && mkdir "$HOME/.local/share"
	[[ ! -d "$HOME/.local/share/applications" ]] && mkdir "$HOME/.local/share/applications"
        cp $ROOTDIR/files/telegram.desktop $HOME/.local/share/applications/telegram.desktop

	[[ ! -d "/etc/skel/.local" ]] && sudo mkdir "/etc/skel/.local"
	[[ ! -d "/etc/skel/.local/share" ]] && sudo mkdir "/etc/skel/.local/share"
	[[ ! -d "/etc/skel/.local/share/applications" ]] && sudo mkdir "/etc/skel/.local/share/applications"
        sudo cp $ROOTDIR/files/telegram.desktop /etc/skel/.local/share/applications/telegram.desktop
}

function desinstalar(){
        rm -r $HOME/.local/share/TelegramDesktop
        if [[ -d /opt/Telegram ]]; then
		rm $HOME/.local/share/applications/appimagekit_*-Telegram_Desktop.desktop
	        rm $HOME/.local/share/applications/telegram*.desktop
	
	        sudo rm /etc/skel/.local/share/applications/telegram.desktop
		sudo rm /usr/local/bin/telegram
		sudo rm /usr/local/bin/telegram-desktop
        	sudo rm -r /opt/Telegram
        else
        	sudo apt-get autoremove --purge telegram-desktop
        fi
}

## LLAMADAS

if [[ "$1" != "-d" ]]; then
    descargar
    iconoMenu
else
    desinstalar
fi

exit 0
