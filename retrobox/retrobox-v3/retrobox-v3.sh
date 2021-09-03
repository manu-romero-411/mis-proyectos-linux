#!/bin/bash
## DESCRIPCIÓN BÁSICA DEL SCRIPT
## FECHA DE CREACIÓN: DD de MMMMM de YYYY

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)) ## TRANSFORMADOR DE UBICACIONES RELATIVAS A ABSOLUTAS PARA EVITAR ERRORES

## FUNCIONES

function error(){ # METE ARGUMENTOS AL LLAMAR A ESTA FUNCIÓN Y SALDRÁ UN MENSAJE DE ERROR CON UNA F (QUE ES LO QUE TE MERECES CUANDO PASAN ERRORES).
	echo "[ERROR] $@. F"
	exit 1
}

function root_checker(){
	if [[ $(id -u) = 0 ]]; then
		echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
		error
	fi
}

function sistema_directorios(){
	sudo mkdir /opt/retrobox
	sudo chown 1000:1000 /opt/retrobox
	mkdir /opt/retrobox/apps-tv
	mkdir /opt/retrobox/bios
	mkdir /opt/retrobox/emulationstation-linux
	mkdir /opt/retrobox/emulationstation/emuladores
	mkdir /opt/retrobox/emulationstation/loaders
	mkdir /opt/retrobox/emulationstation/scripts
	mkdir /opt/retrobox/gamepad-profiles
	mkdir /opt/retrobox/misc
	mkdir /opt/retrobox/saves
}

function predependencias(){
	sudo add-apt-repository -y ppa:beauman/marley
	sudo apt-add-repository -y ppa:dolphin-emu/ppa
	sudo add-apt-repository -y ppa:libretro/stable
	sudo add-apt-repository -y ppa:ppsspp/stable
	sudo apt-get update
	sudo apt-get install -y pcsx2 ppsspp dolphin-emu antimicro retroarch*
}
## LLAMADAS
predependencias

exit 0
