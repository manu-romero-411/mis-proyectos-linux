#!/bin/bash
## CONFIGURACIÓN DE NEMO EN XFCE
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

function terminal_setup(){
	gsettings set org.gnome.desktop.default-applications.terminal exec xfce4-terminal
	gsettings set org.cinnamon.desktop.default-applications.terminal exec xfce4-terminal
}

function desktop_setup(){
	sudo apt-get install -y dconf-editor dconf-cli
	gsettings set org.nemo.desktop ignored-desktop-handlers "['xfdesktop']"
	gsettings set org.nemo.desktop font "Lato 10"
	xfconf-query -c xfce4-desktop -p /desktop-icons/style -n -t int -s 0
	xfconf-query -c xfce4-desktop -p /desktop-menu/show -n -t bool -s false
	xfconf-query -c xfce4-desktop -p /windowlist-menu/show -n -t bool -s false
	[[ ! -d "$HOME/.config/autostart" ]] && mkdir "$HOME/.config/autostart"
	cp "$ROOTDIR/files/nemo-desktop-autostart.desktop" "$HOME/.config/autostart/."
}

function uca(){
	[[ ! -d "$HOME/.local/" ]] && mkdir "$HOME/.local"
	[[ ! -d "$HOME/.local/share/" ]] && mkdir "$HOME/.local/share"
	[[ ! -d "$HOME/.local/share/nemo/" ]] && mkdir "$HOME/.local/share/nemo"
	[[ ! -d "$HOME/.local/share/nemo/actions" ]] && mkdir "$HOME/.local/share/nemo/actions"
	cp "$ROOTDIR/../filemanager-uca/nemo"/* "$HOME/.local/share/nemo/actions"
	chmod -R 755 "$ROOTDIR/../filemanager-uca/scripts"/*

	if echo $PATH | grep "/.local/bin"; then
		[[ ! -d "$HOME/.local/" ]] && mkdir "$HOME/.local"
		[[ ! -d "$HOME/.local/bin/" ]] && mkdir "$HOME/.local/bin"
		cp "$ROOTDIR/../filemanager-uca/scripts"/* "$HOME/.local/bin"
	else
		sudo cp "$ROOTDIR/../filemanager-uca/scripts"/* "/usr/local/bin"
	fi
	sudo apt-get install -y gridsite-clients yad ffmpeg libnotify-bin xdotool
}

function desktopFiles(){
	[[ ! -d "$HOME/.local/" ]] && mkdir "$HOME/.local"
	[[ ! -d "$HOME/.local/share/" ]] && mkdir "$HOME/.local/share"
	[[ ! -d "$HOME/.local/share/applications/" ]] && mkdir "$HOME/.local/share/applications"
	cp $ROOTDIR/files/desktopFiles/* "$HOME/.local/share/applications/"
	sudo chmod 644 /usr/bin/thunar* /usr/bin/Thunar
}

function config(){
	cat $ROOTDIR/files/nemo-config.ini | dconf load /org/nemo/
	sudo chmod -x /usr/bin/thunar* /usr/bin/Thunar*
}

terminal_setup
desktop_setup
uca
desktopFiles
config
exit 0
