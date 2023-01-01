#!/bin/bash
## INSTALADOR DE TELEGRAM
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=org.telegram.desktop
USUARIO=$(id -nu 1000)
GRUPO=$(id -ng 1000)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
        if [[ $(whoami) != root ]]; then
                echo "[MALAMENTE] No eres root"
                error
        fi
}

function instalador(){
	wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
        chown -R $USUARIO:$GRUPO "/opt/Telegram" /opt/Telegram/*
	ln -s "/opt/Telegram/Telegram" "/usr/local/bin/telegram"
	ln -s "/opt/Telegram/Telegram" "/usr/local/bin/telegram-desktop"
	cp "$ROOTDIR/aux-files/telegram/telegram-uninstall.sh" "/opt/Telegram/telegram-uninstall.sh"
	chmod 755 "/opt/Telegram/telegram-uninstall.sh"
	#mkdir -p "/etc/skel/.local/share/applications"
	mkdir -p "$HOME/.config/autostart"
	cp "$ROOTDIR/aux-files/telegram/telegram-desktop.desktop" "$HOME/Escritorio"
	telegram & exit 0
}

function flatpak_inst(){
	if ! dpkg --get-selections | grep flatpak; then
		"$ROOTDIR/flatpak.sh"
	fi
	flatpak install -y flathub $FLATPAK_ID
}

function desinstalar(){
	if dpkg --get-selections | grep flatpak; then
		flatpak uninstall -y $FLATPAK_ID
		flatpak uninstall -y --unused
	fi

	rm /home/$USUARIO/.local/share/applications/*elegram*.desktop
	rm /home/$USUARIO/.config/autostart/*elegram*.desktop
	rm -r /home/$USUARIO/.local/share/TelegramDesktop
	#sudo rm /etc/skel/.local/share/applications/telegram.desktop
	sudo rm /usr/local/bin/telegram*
	sudo rm -r /opt/Telegram
}

## LLAMADAS

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
elif [[ $1 == "-f" ]]; then
	flatpak_inst
else
	instalador
fi

exit 0
