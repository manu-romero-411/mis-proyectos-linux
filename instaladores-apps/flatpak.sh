#!/bin/bash
## FLATPAK
## FECHA DE CREACIÓN: 28 de agosto de 2022

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

function instalar(){
	apt-get -y install flatpak gnome-software-plugin-flatpak || error Error al instalar
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function desinstalar(){
	flatpak uninstall --all --delete-data
	if [ -z $SUDO_USER ]; then
		USUARIO=$(id -nu 1000)
	else
		USUARIO=$SUDO_USER
	fi
	rm -r /home/$USUARIO/.var/apps
	rm -r /home/$USUARIO/.local/share/flatpak
	rm -r /home/$USUARIO/var/lib/flatpak
	apt-get -y autoremove --purge flatpak || error Error al desinstalar
}

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
else
	instalar
fi
exit 0
