#!/bin/bash
## SUSTITUIR XARCHIVER POR ENGRAMPA SI ES QUE SE HA INSTALADO EL PRIMERO
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHAS DE MODIFICACIÓN:

## FUNCIONES PRELIMINARES

function error(){
  echo "[ERROR] Ha ocurrido un error."
  exit 1
}

function root_checker(){
  if [[ $(id -u) != 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

## SECCIÓN 1 DEL SCRIPT

function instalador(){
	apt -y autoremove --purge xarchiver
	apt -y install engrampa p7zip-full rar unrar || error
}

root_checker
instalador

exit 0
