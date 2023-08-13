#!/bin/bash
## CONFIGURADOR DE PLANK
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN: 6 de octubre de 2020, 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
  echo "[ERROR] Ha ocurrido un error."
  exit 1
}

function root_checker(){
  if [[ $(id -u) = 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

function icono_mostrar_escritorio(){
	[[ ! -d "$HOME/.local/share/plank" ]] && mkdir "$HOME/.local/share/plank"
	cp "$ROOTDIR/mostrar-escritorio.desktop" "$HOME/.local/share/plank"
}

function configuracion_predeterminada(){
	NO=0
	killall plank
	for i in google-chrome-stable libreoffice vlc gimp spotify-client nemo wmctrl gedit gnome-disk-utility xfce4-terminal; do
		if ! dpkg -s $i > /dev/null; then
			echo "[INFO] Necesario instalar el paquete $i"
#			if [[ "$i" == "google-chrome-stable" ]]; then
#				sudo $ROOTDIR/insts/chrome.sh
#			fi
#			if [[ "$i" == "libreoffice" ]]; then
#				sudo $ROOTDIR/insts/libreoffice.sh
#			fi
#			if [[ "$i" == "vlc" ]]; then
#				sudo $ROOTDIR/insts/multimedia.sh
#			fi
#			if [[ "$i" == "gimp" ]]; then
#				sudo $ROOTDIR/insts/graficos.sh
#			fi
#			if [[ "$i" == "spotify-client" ]]; then
#				sudo $ROOTDIR/insts/spotify.sh
#			fi
#			if [[ "$i" == "nemo" ]]; then
#				sudo $ROOTDIR/insts/nemo.sh
#			fi
#			if [[ "$i" == "wmctrl" ]]; then
#				sudo $ROOTDIR/insts/system-tools.sh
#			fi
#			if [[ "$i" == "gedit" ]]; then
#				sudo $ROOTDIR/insts/gedit.sh
#			fi
#			if [[ "$i" == "gnome-disk-utility" ]]; then
#				sudo $ROOTDIR/insts/discos.sh
#			fi
			if [[ "$i" == "xfce4-terminal" ]]; then
				sudo apt-get -y install xfce4-terminal
			fi
		fi
	done

	#if [[ ! -d /opt/Telegram ]]; then
	#	NO=1
	#	echo "[INFO] Necesario instalar Telegram"
	#	$ROOTDIR/insts/telegram.sh
	#fi

	if [[ $NO != "1" ]]; then
	#	dconf write /net/launchpad/plank/docks/dock1/dock-items "['mostrar-escritorio.dockitem', 'nemo.dockitem', 'google-chrome.dockitem', 'libreoffice-startcenter.dockitem', 'vlc.dockitem', 'spotify.dockitem', 'gimp.dockitem', 'org.gnome.gedit.dockitem', 'org.gnome.Calculator.dockitem', 'org.gnome.DiskUtility.dockitem', 'xfce4-terminal.dockitem']"
		[[ -d "$HOME/.config/plank" ]] && rm -r "$HOME/.config/plank"
		cp "$ROOTDIR/files/plank/layout" "$HOME/.config/plank" -r
	fi

	[[ ! -d "$HOME/.local" ]] && mkdir "$HOME/.local"
	[[ ! -d "$HOME/.local/share" ]] && mkdir "$HOME/.local/share"
	[[ ! -d "$HOME/.local/share/plank" ]] && mkdir "$HOME/.local/share/plank"
	[[ ! -d "$HOME/.local/share/plank/themes" ]] && mkdir "$HOME/.local/share/plank/themes"
	cp -r "$ROOTDIR/../artwork/plank-themes/matcha-dark" "$HOME/.local/share/plank/themes/matcha-dark"
	#dconf write /net/launchpad/plank/docks/dock1/theme "'theme-matcha-azul'"
	#dconf write /net/launchpad/plank/docks/dock1/icon-size 32
	dconf load /net/launchpad/plank/docks/dock1/ < "$ROOTDIR/files/plank-config.ini"
	sudo cp "$ROOTDIR/files/auxScripts/plank-respawn" "/usr/local/bin"
	sudo chmod 755 "/usr/local/bin/plank-respawn"
	plank-respawn &
}

## LLAMADAS

icono_mostrar_escritorio
configuracion_predeterminada


exit 0
