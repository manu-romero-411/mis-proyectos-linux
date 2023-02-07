#!/bin/bash
## INSTALADOR DE MELD
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
	sudo apt-get install -y meld
}

function desinstalar(){
	sudo apt-get -y autoremove --purge meld
}

#check_root
if [[ "$1" == "-d" ]]; then
	desinstalar
else
	instalador
fi
exit 0
