#!/bin/bash
## SCRIPT PARA ARREGLAR LA APARIENCIA DE LAS APPS QT EN ESCRITORIOS GTK (COMO xfce)
## FECHA DE CREACIÓN: 16 de febrero de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020, 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
        echo "[ERROR] $@. F"
        exit 1
}

function check_root(){
        if [[ $(whoami) != root ]]; then
                echo "[MALAMENTE] No eres root"
                error
        fi
}

check_root
apt-get install -y qt5-gtk-platformtheme qt5-style-plugins qt5ct
if ! cat "/etc/environment" | grep "QT_QPA"; then
	echo "export QT_QPA_PLATFORMTHEME=qt5ct" | tee -a /etc/environment
	NUMLIN=$(cat "/etc/X11/Xsession.d/56xubuntu-session" | grep -n QPA | cut -d":" -f1)
	sed "$NUMLIN s/./#&/" "/etc/X11/Xsession.d/56xubuntu-session" > "/tmp/56xubuntu-session"
	mv "/tmp/56xubuntu-session" "/etc/X11/Xsession.d/56xubuntu-session"
	chmod 755 "/etc/X11/Xsession.d/56xubuntu-session"
	env QT_QPA_PLATFORMTHEME=qt5ct qt5ct
fi
