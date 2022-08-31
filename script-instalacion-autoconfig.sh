#!/bin/bash
## MONTAR SISTEMA BASE E INSTALAR COSAS
## FECHA DE CREACIÓN: 23 de octubre de 2020

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $1. F"
	exit 1
}

function check_root(){
        if [[ $(whoami) != root ]]; then
                echo "[MALAMENTE] No eres root"
                error
        fi
}

function baseInstall1(){
	case $1 in
		"-x"|"--xfce") baseinstall_xfce $2;;
		"-k"|"--kde") baseinstall_kde;;
		"-l"|"--lxde") baseinstall_lxde;;
		"-m"|"--mate") baseinstall_mate;;
		*) baseinstall_xfce;;
	esac
}

function baseinstall_xfce(){
	"$ROOTDIR/baseinstall/debian-lightdm-x.sh"
	"$ROOTDIR/baseinstall/debian-xfce.sh" $1
	"$ROOTDIR/baseinstall/debian-conectividad.sh"
	reboot
}

function baseinstall_lxde(){
	"$ROOTDIR/baseinstall/debian-lightdm-x.sh"
	"$ROOTDIR/baseinstall/debian-lxde.sh"
	"$ROOTDIR/baseinstall/debian-conectividad.sh"
	reboot
}

function baseinstall_mate(){
	"$ROOTDIR/baseinstall/debian-lightdm-x.sh"
	"$ROOTDIR/baseinstall/debian-xfce.sh"
	"$ROOTDIR/baseinstall/debian-conectividad.sh"
	reboot
}

function baseinstall_kde(){
	"$ROOTDIR/baseinstall/debian-kde.sh"
	reboot
}

## LLAMADAS
if [[ $(lsb_release -si) == "Debian" ]] && \
! dpkg --get-selections | grep lxsession && \
! dpkg --get-selections | grep xfce4-session && \
! dpkg --get-selections | grep plasma-desktop && \
! dpkg --get-selections | grep mate-desktop; then
	baseInstall1 $@
fi
exit 0
