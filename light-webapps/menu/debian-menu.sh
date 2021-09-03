#!/bin/bash
## CREAR NUEVAS CATEGORÍAS PARA APLICACIONES Y WEBAPPS
## FECHA DE CREACIÓN: 5 de julio de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
  echo "[ERROR] Ha ocurrido un error."
  exit 1
}

function root_checker(){
  if [[ $(id -u) = 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

#root_checker

cp $ROOTDIR/*.directory /usr/share/desktop-directories
cp /etc/xdg/menus/xfce-applications.menu /etc/xdg/menus/xfce-applications.menu.original
cp $ROOTDIR/xfce-applications.menu.debianmod /etc/xdg/menus/xfce-applications.menu 


exit 0
