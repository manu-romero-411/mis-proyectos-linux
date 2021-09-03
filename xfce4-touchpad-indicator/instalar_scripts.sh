#!/bin/bash
## INSTALADOR DE LOS SCRIPTS DE touchpad-indicator
## FECHA DE CREACIÓN: 6 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 28 de octubre de 2020

ROOTDIR=$(realpath $(dirname $0))

## TODO: DETECTAR PC

chmod 755 "$ROOTDIR/touchpad-indicator"
chmod 755 "$ROOTDIR/touchpad-on-off"

#if echo $PATH | grep "/.local/bin"; then
#	[[ ! -d "$HOME/.local" ]] && mkdir "$HOME/.local"
#	[[ ! -d "$HOME/.local/bin" ]] && mkdir "$HOME/.local/bin"
#	cp "$ROOTDIR/touchpad-indicator" "$HOME/.local/bin"
#	cp "$ROOTDIR/touchpad-on-off" "$HOME/.local/bin"
#	sed -i s#touchpad-on-off#$HOME/.local/bin/touchpad-on-off# $HOME/.local/bin/touchpad-indicator
#	EJECUTABLE="$HOME/.local/bin/touchpad-indicator"
#else
	sudo cp "$ROOTDIR/touchpad-indicator" "/usr/local/bin"
	sudo cp "$ROOTDIR/touchpad-on-off" "/usr/local/bin"
	EJECUTABLE="/usr/local/bin/touchpad-indicator"
#fi
[[ ! -d "$HOME/.config/autostart" ]] && mkdir "$HOME/.config/autostart"
cp "$ROOTDIR/touchpad-indicator-autostart.desktop" "$HOME/.config/autostart/" 

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Estado del panel táctil
Comment=Desactivado (pulsa aquí para activar)
Exec=$EJECUTABLE
Icon=/usr/share/icons/Papirus-Dark/symbolic/devices/input-mouse-symbolic.svg
Path=
Terminal=false
StartupNotify=true" > "$HOME/Escritorio/touchpad-indicator.desktop"
cp "$ROOTDIR/pointers.xml" "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/pointers.xml"
killall xfsettingsd
sleep 1
xfsettingsd &

exit 0
