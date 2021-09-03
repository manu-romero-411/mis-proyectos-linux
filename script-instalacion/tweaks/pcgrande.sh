#!/bin/bash
## SCRIPT DE OPTIMIZACIONES EXCLUSIVAS DEL #pcgrande EN DEBIAN Y UBUNTU
## FECHA DE CREACIÓN: 28 de febrero de 2020
## FECHAS DE MODIFICACIÓN: 11 de octubre de 2020

function scriptOriginal(){
	# LO PRIMERO ES COMENTAR Y DESCOMENTAR ALGUNAS LÍNEAS EN ALGUNOS ARCHIVOS CLAVE DEL SISTEMA
	sed -i s/GRUB_CMDLINE_LINUX_DEFAULT/\#GRUB_CMDLINE_LINUX_DEFAULT/g /etc/default/grub
	sed -i s/\#CPU_BOOST_ON/CPU_BOOST_ON/g /etc/default/tlp

	# PONER OPTIMIZACIONES PARA EL #pcgrande
	echo GRUB_CMDLINE_LINUX_DEFAULT=\"pci=noaer\ pcie_aspm=off\ i915.enable_rc6=0\" >> /etc/default/grub
	update-grub

	# INDICATOR-KEYLOCK
	apt-get -y install $raiz/pkgs/indicator-keylock_3.1.1-0~ppa0_amd64.deb

	# TODO: SONICMASTER
}

