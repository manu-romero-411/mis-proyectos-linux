#!/bin/bash
## INSTALADOR DE FILEZILLA
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
	sudo apt-get install -y filezilla
}

function desinstalar(){
	sudo apt-get -y autoremove --purge filezilla
}

#check_root
if [[ "$1" == "-d" ]]; then
	desinstalar
else
	instalador
fi
exit 0
