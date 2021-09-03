#!/bin/bash
## CONFIGURACIÓN DE thunar EN XFCE
## FECHA DE CREACIÓN: 6 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

ROOTDIR=$(realpath $(dirname $0)/..)

function error(){
  echo "[ERROR] Ha ocurrido un error."
  exit 1
}

function root_checker(){
  if [[ $(id -u) != 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

function desktop_setup(){
	sudo apt-get install -y dconf-editor dconf-cli
	xfconf-query -c xfce4-desktop -p /desktop-menu/show -n -t bool -s false
	xfconf-query -c xfce4-desktop -p /windowlist-menu/show -n -t bool -s false
}

function uca(){
	[[ ! -d "$HOME/.config/" ]] && mkdir "$HOME/.config/"
	[[ ! -d "$HOME/.config/Thunar/" ]] && mkdir "$HOME/.config/Thunar/"
	cp "$ROOTDIR/../filemanager-uca/thunar/uca.xml" "$HOME/.config/Thunar/uca.xml"

	if echo $PATH | grep "/.local/bin"; then
		[[ ! -d "$HOME/.local/" ]] && mkdir "$HOME/.local"
		[[ ! -d "$HOME/.local/bin/" ]] && mkdir "$HOME/.local/bin"
		cp "$ROOTDIR/../filemanager-uca/scripts"/* "$HOME/.local/bin"
	else
		sudo cp "$ROOTDIR/../filemanager-uca/scripts"/* "/usr/local/bin"
	fi
	sudo apt-get install -y gridsite-clients yad ffmpeg libnotify-bin xdotool
}

desktop_setup
uca
exit 0
