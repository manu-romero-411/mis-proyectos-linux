#!/bin/bash
## INSTALADOR Y CONFIGURADOR DE PAQUETES RELACIONADOS CON EMOJIS
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN: 7 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install --autoremove --purge fonts-noto-color-emoji gnome-characters gucharmap || error
}

function config(){
	[[ ! -d "$HOME/.config/fontconfig/" ]] && mkdir "$HOME/.config/fontconfig/"
	[[ ! -d "$HOME/.config/fontconfig/conf.d" ]] && mkdir "$HOME/.config/fontconfig/conf.d"
	echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>
</fontconfig>" > "$HOME/.config/fontconfig/conf.d/01-emoji.conf"
	fc-cache -f -v || error Ha fallado la regeneración de la caché de tipografías
}

## LLAMADAS

#check_root
instalador
config

exit 0
