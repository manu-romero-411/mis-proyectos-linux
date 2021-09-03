#!/bin/bash
## INSTALADOR DE PAQUETES DE DESARROLLO
## FECHA DE CREACIÓN: 1 de noviembre de 2020
## FECHAS DE MODIFICACIÓN: 11 de abril de 2021

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)/..)

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		error No eres root
	fi
}

function instalador(){
	sudo apt-get -y install meld ghex shellcheck build-essential cmake make shellcheck jupyter
	$ROOTDIR/insts/vscode.sh
}

## LLAMADAS

instalador

exit 0
