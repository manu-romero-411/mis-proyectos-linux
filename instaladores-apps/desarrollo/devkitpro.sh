#!/bin/bash
## INSTALADOR DE DEVKITPRO
## FECHA: 2 de enero de 2023

ROOTDIR="$(realpath $(dirname $0))"

function error() {
	echo "[ERROR] $@. F"
	exit 1
}

function check_root() {
	if [[ $(whoami) != root ]]; then
		echo "[MALAMENTE] No eres root"
		error
	fi
}

function instalador() {
	# ensure apt is set up to work with https sources
	apt-get install apt-transport-https

	# Store devkitPro gpg key locally if we don't have it already
	if ! [ -f /usr/share/keyrings/devkitpro-pub.gpg ]; then
		mkdir -p /usr/share/keyrings/
		wget -O /usr/share/keyrings/devkitpro-pub.gpg https://apt.devkitpro.org/devkitpro-pub.gpg
	fi

	# Add the devkitPro apt repository if we don't have it set up already
	if ! [ -f /etc/apt/sources.list.d/devkitpro.list ]; then
		echo "deb [signed-by=/usr/share/keyrings/devkitpro-pub.gpg] https://apt.devkitpro.org stable main" >/etc/apt/sources.list.d/devkitpro.list
	fi

	# Finally install devkitPro pacman
	apt-get update
	apt-get -y install devkitpro-pacman
}

function desinstalar() {
	sudo apt-get -y autoremove --purge devkitpro-pacman
	sudo rm /usr/share/keyrings/devkitpro-pub.gpg
	sudo rm /etc/apt/sources.list.d/devkitpro.list
	sudo rm -r /opt/devkitpro
	sudo rm /etc/profile.d/devkit-env.sh
}

check_root
if [[ "$1" == "-d" ]]; then
	desinstalar
else
	instalador
fi
exit 0
