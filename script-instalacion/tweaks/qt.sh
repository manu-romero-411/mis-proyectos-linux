#!/bin/bash
## SCRIPT PARA ARREGLAR LA APARIENCIA DE LAS APPS QT EN ESCRITORIOS GTK (COMO xfce)
## FECHA DE CREACIÓN: 16 de febrero de 2020
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

#if [[ $(whoami) != "root" ]]; then
#	echo "No eres root."
#fi

sudo apt-get install -y qt5-gtk-platformtheme qt5-style-plugins
sudo sh -c "echo 'QT_QPA_PLATFORMTHEME=gtk2' >> /etc/environment"
