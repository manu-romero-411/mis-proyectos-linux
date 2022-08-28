#!/bin/bash
## INSTALADOR DE APLICACIONES DE GRÁFICOS
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 11 de abril de 2020, 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	$ROOTDIR/kolourpaint.sh || error
	$ROOTDIR/gimp.sh || error
	$ROOTDIR/krita.sh -f || error
	$ROOTDIR/inkscape.sh || error
}

## LLAMADAS

instalador

exit 0
