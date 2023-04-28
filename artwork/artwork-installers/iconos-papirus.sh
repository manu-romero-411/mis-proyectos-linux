#!/bin/bash
## ICONOS GTK: PAPIRUS
## FECHA DE CREACIÓN: 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES PRELIMINARES

function error(){
	echo "[ERROR] Ha ocurrido un error."
	exit 1
}

function check_root(){
	if [[ $(id -u) != 0 ]]; then
		echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
		error
	fi
}

function instalar(){
	if [[ $(lsb_release -si) == "Debian" ]]; then
		#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/SmartFinn:/hardcode-tray/Debian_10/ /' > /etc/apt/sources.list.d/hardcode-tray.list"
		#wget -qO- https://download.opensuse.org/repositories/home:SmartFinn:hardcode-tray/Debian_$(lsb_release -rs)/Release.key | sudo apt-key add -

		echo "deb [signed-by=/usr/share/keyrings/papirus.gpg] http://ppa.launchpad.net/papirus/papirus/ubuntu focal main" | tee "/etc/apt/sources.list.d/papirus-ppa.list"
		apt-get -y install dirmngr
		mkdir -p /root/.gnupg
		gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/papirus.gpg --keyserver keyserver.ubuntu.com --recv E58A9D36647CAE7F
		chmod 644 /usr/share/keyrings/papirus.gpg
	else
		sudo add-apt-repository -y ppa:papirus/papirus
	fi
	sudo apt-get update
        sudo apt-get -y install papirus-icon-theme papirus-folders
        papirus-folders -C teal
}

function desinstalar(){
	sudo apt-get autoremove --purge -y papirus-icon-theme papirus-folders
}

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
else
	instalar
fi
exit 0
