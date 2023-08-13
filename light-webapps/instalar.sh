#!/bin/bash
## INSTALADOR DE LIGHT WEBAPPS
## FECHA DE CREACIÓN: 12 de julio de 2020
## FECHAS DE MODIFICACIÓN: 23 de julio de 2020, 28 de octubre de 2020, 

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function ayuda(){
	echo "USO: $1 [-r apps-a-excluir separadas con espacio]"
	echo "Ejemplo: $1 -r google-docs google-spreadsheets google-slides ms-word ms-powerpoint ms-excel uja-google-docs uja-google-slides uja-google-spreadsheets"
	exit 1
}

function quitar_webapps_repetidas(){
	for arg; do
		if dpkg --get-selections | grep $arg; then
			rm "$HOME/.local/share/applications/webapp-$arg.desktop"
		else
			if [[ $arg == "telegram" ]] && [[ -d "/opt/Telegram" ]] && [[ -f "$HOME/.local/share/applications/webapp-telegram.desktop" ]]; then
				rm "$HOME/.local/share/applications/webapp-telegram.desktop"
			fi
			if [[ $arg == "spotify" ]] && dpkg --get-selections spotify-client && [[ -f "$HOME/.local/share/applications/webapp-spotify.desktop" ]]; then
				rm "$HOME/.local/share/applications/webapp-spotify.desktop"
			fi
		fi
	done
}

function instalar(){
	[[ ! -d "$HOME/.local" ]] && mkdir "$HOME/.local"
	[[ ! -d "$HOME/.local/share" ]] && mkdir "$HOME/.local/share"
	[[ ! -d "$HOME/.local/share/applications" ]] && mkdir "$HOME/.local/share/applications"
	lista_non
	#cp $ROOTDIR/papirus/*.desktop "$HOME/.local/share/applications"
	if [[ $1 == "-r" ]]; then
		excluir $@
	fi
	quitar_webapps_repetidas telegram discord skype simplenote geogebra spotify
	sudo cp "$ROOTDIR/../modo-tv/scripts/webapp-wrapper" "/usr/local/bin"

	## ESTO SOLO PODRÁ FUNCIONAR BIEN SI ESTAMOS EN XFCE. HAY QUE ARREGLARLO

	if [[ "$(lsb_release -si)" == "Ubuntu" ]]; then
		sudo bash "$ROOTDIR/menu/xubuntu-menu.sh"
	else
		sudo bash "$ROOTDIR/menu/debian-menu.sh"
	fi
}

function iconos_extra(){
	[[ ! -d "$HOME/.icons" ]] && mkdir "$HOME/.icons/"
	#cp -r "$ROOTDIR/non-papirus/app-icons" "$HOME/.icons/app-icons"
}

function instalar_generic_non(){
	#cp "$ROOTDIR/non-papirus/webapp-$1.desktop" "$HOME/.local/share/applications"
}

function lista_non(){
	iconos_extra
	for i in primevideo animeflv blogger cambridge-dictionary diccionario-de-la-rae google-play-libros hbo mitele shazam traductor-de-google tunein wallapop wattpad wordreference; do
		instalar_generic_non $i
	done
}

function excluir(){
	for arg; do
		[[ -f "$HOME/.local/share/applications/webapp-$arg.desktop" ]] && rm "$HOME/.local/share/applications/webapp-$arg.desktop"
	done
}

function desinstalar(){
	rm $HOME/.local/share/applications/webapp-*.desktop
	sudo rm "/usr/local/bin/webapp-wrapper"
}

## LLAMADAS

if [[ -z $1 ]] || [[ $1 == "-r" ]]; then
	instalar $@
elif [[ "$1" == "-h" ]]; then
	ayuda $0
	exit 1
elif [[ "$1" == "-d" ]]; then
	desinstalar
else
	echo "[ERROR] Argumento inválido"
	ayuda $0
	exit 1
fi
exit 0
