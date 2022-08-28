#!/bin/bash
## TEMA GTK: MATCHA
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
	git clone https://github.com/vinceliuice/Matcha-gtk-theme.git /tmp/matcha
	/tmp/matcha/install.sh
	rm -r /tmp/matcha
}

function desinstalar(){
	rm -r "/usr/share/themes/Matcha-aliz"
	rm -r "/usr/share/themes/Matcha-azul"
	rm -r "/usr/share/themes/Matcha-sea"
	rm -r "/usr/share/themes/Matcha-pueril"
	rm -r "/usr/share/themes/Matcha-light-aliz"
	rm -r "/usr/share/themes/Matcha-light-azul"
	rm -r "/usr/share/themes/Matcha-light-sea"
	rm -r "/usr/share/themes/Matcha-light-pueril"
	rm -r "/usr/share/themes/Matcha-dark-aliz"
	rm -r "/usr/share/themes/Matcha-dark-azul"
	rm -r "/usr/share/themes/Matcha-dark-sea"
	rm -r "/usr/share/themes/Matcha-dark-pueril"
}

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
else
	instalar
fi
exit 0
