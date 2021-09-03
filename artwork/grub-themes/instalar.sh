#!/bin/bash
## SCRIPT PARA INSTALAR UN TEMA DE GRUB
## FECHA DE CREACIÓN: 7 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $*. F"
	exit 1
}

function check_root(){
	if [[ $(whoami) != root ]]; then
		error No eres root
	fi
}


function instalar(){
	[[ -d "/boot/grub/grub-theme-$1" ]] && rm -r "/boot/grub/grub-theme-$1"
	cp "$ROOTDIR/grub-theme-$1" -r "/boot/grub/grub-theme-$1"
	! grep GRUB_THEME "/etc/default/grub" && echo "GRUB_THEME=/boot/grub/grub-theme-$1/theme.txt" >> /etc/default/grub
	[[ -f "/boot/grub/grub-theme-$1/config.sh" ]] && "/boot/grub/grub-theme-$1/config.sh"
	update-grub
}

## LLAMADAS

if [[ ! -z $1 ]]; then
	check_root
	instalar $1
else
	SSTR="grub-theme-"
	echo " "
	echo "[INFO] Temas disponibles:"
	for i in $ROOTDIR/*; do
		if [[ "$i" == *"$SSTR"* ]]; then
			echo "*" $(basename $i) | sed -e "s/grub-theme-//"
		fi
	done
	echo " "
	error No se ha indicado ningún tema para instalar
fi

exit 0
