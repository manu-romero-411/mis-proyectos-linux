#!/bin/bash
## HARDCODE TRAY PARA DISCORD
## AUTOR: Desconocido
## FECHA DE CREACIÓN: Desconocida
## FECHA DE MODIFICACIÓN: 23 de octubre de 2020, 5 de marzo de 2021

ROOTDIR=$(realpath $(dirname $0)/..)
DISCORDVERSION=0.0.15

#if [[ -d "/opt/Discord" ]]; then
if dpkg --get-selections | grep discord; then
	if ! dpkg --get-selections | grep npm; then
		sudo apt install -y npm
		INSTALADO=1
	fi
	sudo npm install -g asar
	asar e $HOME/.config/discord/$DISCORDVERSION/modules/discord_desktop_core/core.asar $HOME/.config/discord/$DISCORDVERSION/modules/discord_desktop_core/core
	echo WAIT
	read
	for i in $ROOTDIR/files/discord-hardcode-tray/*.png; do
		cp -rv "$(realpath $i)" "$HOME/.config/discord/$DISCORDVERSION/modules/discord_desktop_core/core/app/images/systemtray/linux/$(basename $i)"
	done
	echo wait
	read
	asar p $HOME/.config/discord/$DISCORDVERSION/modules/discord_desktop_core/core $HOME/.config/discord/$DISCORDVERSION/modules/discord_desktop_core/core.asar
	rm -rfv $HOME/.config/discord/$DISCORDVERSION/modules/discord_desktop_core/core
	sudo npm uninstall -g asar
	if [[ $INSTALADO == "1" ]]; then
		sudo apt-get autoremove --purge -y npm
		sudo apt-get autoremove --purge -y
	fi
fi
