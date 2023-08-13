#!/bin/bash
## DESCRIPCIÓN BÁSICA DEL SCRIPT
## FECHA DE CREACIÓN: DD de MMMMM de YYYY
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0)) ## TRANSFORMADOR DE UBICACIONES RELATIVAS A ABSOLUTAS PARA EVITAR ERRORES

## FUNCIONES

function error(){ # METE ARGUMENTOS AL LLAMAR A ESTA FUNCIÓN Y SALDRÁ UN MENSAJE DE ERROR CON UNA F (QUE ES LO QUE TE MERECES CUANDO PASAN ERRORES).
  echo "[ERROR] $@. F"
  exit 1
}

function root_checker(){
  if [[ $(id -u) = 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error
  fi
}

## LLAMADAS

exit 0
