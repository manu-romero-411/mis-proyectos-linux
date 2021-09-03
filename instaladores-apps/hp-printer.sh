#!/bin/bash
## INSTALADOR DE DRIVERS Y APLICACIONES DE IMPRESORA HP
## FECHA DE CREACIÓN: 23 de junio de 2020
## FECHA DE MODIFICACIÓN:

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function instalador(){
	sudo apt-get -y install hplip system-config-printer simple-scan || error
}

instalador
exit 0
