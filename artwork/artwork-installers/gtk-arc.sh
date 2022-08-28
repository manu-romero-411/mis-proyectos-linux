#!/bin/bash
## TEMA GTK: ARC
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
	sudo apt-get install -y arc-theme
}

function desinstalar(){
	sudo apt-get -y autoremove --purge arc-theme
}

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
else
	instalar
fi
exit 0
