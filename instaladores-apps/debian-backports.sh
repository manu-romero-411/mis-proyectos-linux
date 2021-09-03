#!/bin/bash
## AÑADIR REPOSITORIO DE BACKPORTS EN DEBIAN
## FECHA DE CREACIÓN: 22 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

if [[ "$(lsb_release -si)" == "Debian" ]]; then
	if [[ "$(lsb_release -sc)" == "buster" ]] || [[ "$(lsb_release -sc)" == "stretch" ]]; then ## esto se debe actualizar cada vez que saquen una versión nueva de Debian
		echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | sudo tee /etc/apt/sources.list.d/debian-backports.list
		sudo apt-get update || exit 1
	fi
fi
exit 0
