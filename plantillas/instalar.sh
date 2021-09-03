#!/bin/bash
## INSTALAR PLANTILLAS
## FECHA DE CREACIÓN: 28 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
  echo "[ERROR] $@. F"
  exit 1
}

function root_checker(){
  if [[ $(id -u) = 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

function instalar(){
	cp $ROOTDIR/* "$HOME/Plantillas"
}

function desinstalar(){
	rm $HOME/Plantillas/*
}

## LLAMADAS

if ! [[ "$1" == "-d" ]]; then
	instalar
else
	desinstalar
fi
exit 0
