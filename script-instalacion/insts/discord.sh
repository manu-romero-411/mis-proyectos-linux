#!/bin/bash
## INSTALADOR DE DISCORD
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
	sudo wget -O- "https://discord.com/api/download?platform=linux&format=tar.gz" | sudo tar xz -C /opt
        sudo chown -R $(whoami):$(whoami) /opt/Discord /opt/Discord/*
	sudo ln -s /opt/Discord/Discord /usr/local/bin/discord
	sudo chown root:root /opt/Discord/chrome-sandbox
	sudo chmod 4755 /opt/Discord/chrome-sandbox
}

function iconoMenu(){
        #cp $ROOTDIR/files/discord.desktop $HOME/.local/share/applications/discord.desktop
        sudo cp $ROOTDIR/files/discord.desktop /usr/share/applications/discord-linux.desktop
}

function desinstalar(){
        sudo rm /usr/share/applications/discord-linux.desktop
        rm -r $HOME/.config/discord
	sudo rm /usr/local/bin/discord
        sudo rm -r /opt/Discord
}

## LLAMADAS

if [[ "$1" != "-d" ]]; then
    descargar
    iconoMenu
else
    desinstalar
fi

exit 0
