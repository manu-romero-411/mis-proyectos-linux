#!/bin/bash
## INSTALADOR DE LOS SCRIPTS DE touchpad-indicator
## FECHA DE CREACIÓN: 6 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 28 de octubre de 2020

ROOTDIR=$(realpath $(dirname $0))

## TODO: DETECTAR PC

chmod 755 "$ROOTDIR/antidesconcentramiento"

	sudo cp "$ROOTDIR/antidesconcentramiento" "/usr/local/bin"
	EJECUTABLE="/usr/local/bin/antidesconcentramiento toggle"
#fi
[[ ! -d "$HOME/.config/autostart" ]] && mkdir "$HOME/.config/autostart"
cp "$ROOTDIR/antidesconcentramiento-autostart.desktop" "$HOME/.config/autostart/" 

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Modo anti-desconcentramiento
Exec=$EJECUTABLE
Icon=/usr/share/icons/Papirus-Dark/16x16/actions/object-locked.svg
Path=
Terminal=false
StartupNotify=true" > "$HOME/Escritorio/antidesconcentramiento.desktop"

exit 0
