#!/bin/bash
## AÑADIR REPOSITORIO DE BACKPORTS EN DEBIAN
## FECHA DE CREACIÓN: 22 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

DEBIAN_VERSION_CODENAME=$(lsb_release -sc)

if [[ "$(lsb_release -si)" == "Debian" ]]; then
	if [[ "$DEBIAN_VERSION_CODENAME" == "buster" ]] || [[ "$DEBIAN_VERSION_CODENAME" == "bullseye" ]]; then ## esto se debe actualizar cada vez que saquen una versión nueva de Debian
		echo "deb http://deb.debian.org/debian ${DEBIAN_VERSION_CODENAME}-backports main" | sudo tee "/etc/apt/sources.list.d/debian-backports.list"
		sudo apt-get update || exit 1
	fi
fi
exit 0
