#!/bin/bash
## INSTALAR SOPORTE PARA MODO TV
## FECHA DE CREACIÓN: 23 de julio de 2020
## FECHAS DE MODIFICACIÓN: 28 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalar(){
	## INSTALAR KDE CONNECT
	sudo apt install -y kdeconnect

	## REGLA DE UDEV PARA CUANDO QUITAMOS EL HDMI (FUNCIONA MEJOR CON LINUX 5.4+ COMO KERNEL)
	sudo cp "$ROOTDIR/10-hdmi-hotplug.rules" "/etc/udev/rules.d" || error No se ha podido copiar el archivo

	## SCRIPTS QUE HACEN FUNCIONAR TO ESTO
	sudo cp $ROOTDIR/scripts/* "/usr/local/bin" || error No se ha podido copiar el archivo

	## ARCHIVOS AUXILIARES (PERFILES DE PANEL Y PLANK, ETC)
	[[ ! -d "$HOME/.local/lib" ]] && mkdir "$HOME/.local/lib"
	cp -r "$ROOTDIR/modo-tv" "$HOME/.local/lib/modo-tv" || error No se han podido copiar los datos del ModoTV

	## ARCHIVO QUE SE EJECUTARÁ AL INICIO, QUE PERMITIRÁ GESTIONAR EL ACCESO AUTOMÁTICO AL MODO TV SI INICIAMOS CON UN HDMI CONECTADO
	[[ ! -d "$HOME/.config/autostart" ]] && mkdir "$HOME/.config/autostart"
	cp "$ROOTDIR/reiniciador-modo-tv.desktop" "$HOME/.config/autostart/reiniciador-modoTV.desktop" || error Fallo al copiar archivo
}

function desinstalar(){
	## REGLA DE UDEV PARA CUANDO QUITAMOS EL HDMI
	sudo rm "/etc/udev/rules.d/10-hdmi-hotplug.rules" # || error No se ha podido borrar el archivo

	## SCRIPTS QUE HACEN FUNCIONAR TO ESTO
	for i in $(ls $ROOTDIR/scripts/); do
		sudo rm "/usr/local/bin/$i" # || error No se ha podido borrar el archivo $i
	done

	## ARCHIVOS AUXILIARES (PERFILES DE PANEL Y PLANK, ETC)
	rm -r "$HOME/.local/lib/modo-tv" # || error Fallo al borrar carpeta

	## ARCHIVO QUE SE EJECUTARÁ AL INICIO, QUE PERMITIRÁ GESTIONAR EL ACCESO AUTOMÁTICO AL MODO TV SI INICIAMOS CON UN HDMI CONECTADO
	rm $HOME/.config/autostart/reiniciador-modo-tv.desktop # || error Fallo al borrar archivo
}

function ayuda(){
	echo "[USO] $0 [-d]"
	echo " "
	echo " "
	echo "[INFO] Si no pones ningún argumento, se copiarán los archivos. Si pones -d se verá si están los archivos instalados, y se borrarán del sistema"
	exit 1
}

## LLAMADAS

if [[ "$1" == "-d" ]]; then
	desinstalar
else
	if [[ -z "$1" ]]; then
		instalar
	else
		ayuda
	fi
fi

exit 0
