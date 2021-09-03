#!/bin/bash
## CREAR NUEVAS CATEGORÍAS PARA APLICACIONES Y WEBAPPS
## FECHA DE CREACIÓN: 5 de julio de 2020
## FECHAS DE MODIFICACIÓN:

## FUNCIONES PRELIMINARES

function error_handler(){
  echo "[ERROR] Ha ocurrido un error."
  exit 1
}

function root_checker(){
  if [[ $(id -u) != 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

root_checker

cp *.directory /usr/share/desktop-directories
cp /etc/xdg/xdg-xubuntu/menus/xfce-applications.menu /etc/xdg/xdg-xubuntu/menus/xfce-applications.menu.original
cp xfce-applications.menu.xubuntumod /etc/xdg/xdg-xubuntu/menus/xfce-applications.menu 


exit 0
