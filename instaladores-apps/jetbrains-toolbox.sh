#!/bin/bash
## INSTALADOR DE JETBRAINS TOOLBOX
## FECHA DE CREACIÓN: 28 de agosto de 2022
## FECHAS DE MODIFICACIÓN:

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
	if [ -d $HOME/.local/share/JetBrains/Toolbox ]; then
		error "JetBrains Toolbox is already installed!"
	fi

	wget --show-progress -qO /tmp/toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"

	TOOLBOX_TEMP_DIR=$(mktemp -d)

	tar -C "$TOOLBOX_TEMP_DIR" -xf /tmp/toolbox.tar.gz || error Ha ocurrido algo
	rm /tmp/toolbox.tar.gz

	"$TOOLBOX_TEMP_DIR"/*/jetbrains-toolbox
	rm -r "$TOOLBOX_TEMP_DIR"
}

## LLAMADAS

instalador

exit 0
