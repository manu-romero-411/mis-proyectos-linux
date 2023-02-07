#!/bin/bash
## INSTALADOR DE HERRAMIENTAS DE MAME COMO CHDMAN
## FECHA: 1 de enero de 2023

ROOTDIR="$(realpath $(dirname $0))"

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		echo "[MALAMENTE] No eres root"
		error
	fi
}

function instalador(){
	sudo apt-get install -y mame-tools --no-install-recommends
	for i in "$ROOTDIR/post-install-configs/mame-tools/*"; do
		sudo cp $i /usr/local/bin
		sudo chmod 755 "/usr/local/bin/$(basename $i)"
	done
}

function desinstalar(){
	sudo apt-get -y autoremove --purge mame-tools
        for i in "$ROOTDIR/post-install-configs/mame-tools/*"; do
		sudo rm -f "/usr/local/bin/$(basename $i)"
	done
}

#check_root
if [[ "$1" == "-d" ]]; then
	desinstalar
else
	instalador
fi
exit 0
