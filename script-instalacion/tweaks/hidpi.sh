#!/bin/bash
## PUESTA A PUNTO DE XFCE EN PANTALLAS HIDPI/RETINA
## FECHA DE CREACIÓN: 11 de abril de 2021

ROOTDIR=$(realpath $(dirname $0)/../)

function gtk3(){
	xfconf-query -c xsettings -p /Gdk/WindowScalingFactor -s 2
}

function gtk2(){
	true
}

function qt(){
	sudo sh -c "echo QT_AUTO_SCREEN_SCALE_FACTOR=0 >> /etc/environment"
	sudo sh -c "echo QT_SCALE_FACTOR=2 >> /etc/environment"
}

function xfwm4(){
	true
}

qt
exit 0
