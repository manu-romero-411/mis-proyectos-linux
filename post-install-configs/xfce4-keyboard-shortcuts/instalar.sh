#!/bin/bash
## INSTALADOR DE ATAJOS DE TECLADO PARA XFCE
## FECHA: 1 de noviembre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function instalar(){
	cp "$ROOTDIR/basic.xml" "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" || exit 1
	xfce4-session-logout -rf || sudo reboot
}

## LLAMADAS

instalar
exit 0
