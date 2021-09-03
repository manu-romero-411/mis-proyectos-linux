#!/bin/bash
## DESCARGADOR DE TEMAS VISUALES
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN: 6 de octubre de 2020, 7 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES PRELIMINARES

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

## TEMAS GTK

function matcha(){
	git clone https://github.com/vinceliuice/Matcha-gtk-theme.git
	sudo bash Matcha-gtk-theme/install.sh
}

function arc(){
	sudo apt-get install -y arc-theme
}

function adapta(){
	sudo apt-get install -y adapta-gtk-theme --no-install-recommends
}

## FONDOS
function desktop_base(){
	sudo apt-get install -y desktop-base
}

## TEMAS DE ICONOS

function papirus(){
	echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu focal main' | sudo tee "/etc/apt/sources.list.d/papirus-ppa.list"
#	sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/SmartFinn:/hardcode-tray/Debian_10/ /' > /etc/apt/sources.list.d/hardcode-tray.list"
	#wget -qO- https://download.opensuse.org/repositories/home:SmartFinn:hardcode-tray/Debian_$(lsb_release -rs)/Release.key | sudo apt-key add -
	sudo apt-get -y install dirmngr
	sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E58A9D36647CAE7F
	sudo apt-get -y update
	sudo apt-get -y install papirus-icon-theme
	papirus-folders -C blue
}

## PANEL

function panel_preliminar(){
	sudo apt-get install -y xfce4-indicator-plugin xfce4-whiskermenu-plugin xfce4-places-plugin xfce4-notifyd xfce4-screenshooter "$ROOTDIR/files/xfpanel-switch_1.0.7-0ubuntu2_all.deb"
	sudo ln -s "/usr/bin/xfpanel-switch" "/usr/local/bin/xfce4-panel-profiles"

}

function panel_macStyle(){
	xfce4-panel-profiles load "$ROOTDIR/files/panel-macStyle.tar.bz2"
	sudo apt-get install -y plank
	$ROOTDIR/tweaks/plank-config.sh
	[[ ! -d "$HOME/.config" ]] && mkdir "$HOME/.config"
	[[ ! -d "$HOME/.config/autostart" ]] && mkdir "$HOME/.config/autostart"
	cp "$ROOTDIR/files/plank-autostart.desktop" "$HOME/.config/autostart"
	cp "$ROOTDIR/files/whiskermenu-1.rc" "$HOME/.config/xfce4/panel/whiskermenu-1.rc"
}

function panel_winXPstyle(){
	xfce4-panel-profiles load "$ROOTDIR/files/panel-xpStyle.tar.bz2"
}

## PONER AJUSTES EN EL ESCRITORIO

function ajustes(){
	xfconf-query -c xsettings -p /Net/ThemeName -s Arc-Dark
	xfconf-query -c xfwm4 -p /general/theme -s Arc-Dark
	xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark
	font_antialias
}

## FUENTES
function droidsans(){
	sudo apt-get install -y "$ROOTDIR/files/fonts-droid_4.3-3ubuntu1_all.deb"
	if dpkg --get-selections | grep xfce4-session; then
		xfconf-query -c xfwm4 -p /general/title_font -s "Droid Sans Bold 10"
		xfconf-query -c xsettings -p /Gtk/FontName -s "Droid Sans 10"
	fi
}

function ubuntufont(){
	sudo apt-get install -y ttf-ubuntu-font-family
	if dpkg --get-selections | grep xfce4-session; then
		xfconf-query -c xfwm4 -p /general/title_font -s "Ubuntu Medium 10"
		xfconf-query -c xsettings -p /Gtk/FontName -s "Ubuntu 10"
	fi
}

function lato(){
        sudo apt-get install -y fonts-lato
        if dpkg --get-selections | grep xfce4-session; then
        	xfconf-query -c xfwm4 -p /general/title_font -s "Lato Bold 10"
        	xfconf-query -c xsettings -p /Gtk/FontName -s "Lato Regular 10"
        fi
}

function font_antialias(){
	xfconf-query -c xsettings -p /Xft/Antialias -s 1
	xfconf-query -c xsettings -p /Xft/Hinting -s 1
	xfconf-query -c xsettings -p /Xft/HintStyle -s hintslight
	xfconf-query -c xsettings -p /Xft/RGBA -s rgb
}

## LLAMADAS A FUNCIONES
#root_checker
#matcha

if [[ -z $1 ]]; then
	adapta
	papirus
	if [[ $(lsb_release -is) == "Ubuntu" ]]; then
		ubuntufont
	else
		#desktop_base
		lato
	fi
	if dpkg --get-selections | grep xfce4-session; then
		panel_preliminar
		panel_winXPstyle
		ajustes
	fi
else
	$1 || error
fi
exit 0
