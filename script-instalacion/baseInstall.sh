#!/bin/bash
## MONTAR SISTEMA BASE E INSTALAR COSAS
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN:

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))

## FUNCIONES

function error(){
	echo "[ERROR] $1. F"
	exit 1
}

function baseInstall1(){
	## SERVIDOR GRÁFICO
	INSTALAR="xserver-xorg-core xinit xorg"
	if [ $(arch) != "amd64" ] && [ $(arch) != "i386" ] && [ $(arch) != "i686" ]; then
		INSTALAR="$INSTALAR xserver-xorg-input-libinput xserver-xorg-input-all xserver-xorg-input-kbd"
	else
		INSTALAR="$INSTALAR xserver-xorg-video-intel xserver-xorg-input-libinput xserver-xorg-input-all xserver-xorg-input-kbd xserver-xorg-input-synaptics"
	fi

	## x86-32 - ENTORNO DE ESCRITORIO LXDE OG (ARMATOSTE)
	if [[ $(arch) == "i386" ]] || [[ $(arch) == "i686" ]]; then
		INSTALAR2="lxsession lxpanel openbox pcmanfm lxterminal desktop-base xfce4-power-manager xfce4-power-manager-plugins xfce4-notifyd lxpolkit"
		INSTALAR="$INSTALAR lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"

		INSTALAR3="network-manager network-manager-gnome"
		INSTALAR3="$INSTALAR3 blueman bluez"

	## x86-64 - ENTORNO DE ESCRITORIO XFCE (PCGRANDE)
	else
		if [[ $(arch) == "amd64" ]] || [[ $(arch) == "x86_64" ]] || [[ $(arch) == "x86-64" ]]; then
			echo 64
			INSTALAR="$INSTALAR lightdm slick-greeter lightdm-settings"
			INSTALAR2="xfwm4 xfce4-terminal xfce4-panel xfce4-session xfdesktop4 desktop-base"
			if echo $@ | grep "--xfce4-nemo"; then
				NEMOINST=1
			else
				INSTALAR2="$INSTALAR2 thunar"
			fi

			INSTALAR3="network-manager network-manager-gnome"
			INSTALAR3="$INSTALAR3 blueman bluez"

	## arm64 - ENTORNO DE ESCRITORIO KDE (MACBOOK CON APPLE SILICON - VIRTUALIZADO)
		else
			if [[ $(arch) == "arm64" ]] || [[ $(arch) == "aarch64" ]]; then
				INSTALAR="$INSTALAR sddm" # no sé cómo va el tema de los temas en sddm
				INSTALAR="$INSTALAR desktop-base plasma-desktop"
			fi
		fi
	fi

	## CONFIGURADORES DE RED Y BLUETOOTH

	### INSTALAR PAQUETES
	sudo apt-get -y install $INSTALAR
	sudo apt-get -y install $INSTALAR2 --no-install-recommends
	sudo apt-get -y install $INSTALAR3
	if [ ! -z $NEMOINST ]; then
		$ROOTDIR/insts/nemo.sh
	fi

	### REINICIAR
	sudo reboot

}

function baseInstall2_comun(){
	### ELIMINAR EL APAÑO TEMPORAL DEL WIFI
	#sudo rm /etc/wpa_supplicant.conf

	### INSTALAR MÁS COSAS

	#### TAREAS
	clear
	$ROOTDIR/tareas/system-tools.sh
	$ROOTDIR/tareas/multimedia.sh
	$ROOTDIR/tareas/graficos.sh
	$ROOTDIR/tareas/devel.sh

	#### NAVEGADORES
	clear
	$ROOTDIR/insts/chromium.sh #PROVISIONAL

	#### APLICACIONES VARIAS
	clear
	$ROOTDIR/insts/discos.sh
	$ROOTDIR/insts/gedit.sh
	$ROOTDIR/insts/paquetes.sh
	baseInstall2_selector

	#### OTRAS COSITAS
	clear
	$ROOTDIR/insts/emoji.sh

	#### USEREXPERIENCE
	clear
	$ROOTDIR/tweaks/apariencia.sh
	$ROOTDIR/tweaks/qt.sh
	sudo $ROOTDIR/tweaks/sudo-asteriscos.sh

	#### OPTIMIZACIONES DEL SISTEMA
	clear
	$ROOTDIR/tweaks/optimizaciones.sh
	#$ROOTDIR/insts/powertop.sh
	#$ROOTDIR/insts/tlp.sh
	$ROOTDIR/../rc.local/instalar.sh

	#### XFCE: COMPONENTES EXTRA
	clear
	if dpkg --get-selections | grep xfce4-session; then
		$ROOTDIR/insts/xfce-extra.sh
		if dpkg --get-selections | grep thunar; then
			$ROOTDIR/tweaks/thunar-config.sh
		elif dpkg --get-selections | grep nemo; then
			$ROOTDIR/tweaks/nemo-config.sh
		fi
		chmod 755 $ROOTDIR/../xfce4-touchpad-indicator/instalar_scripts.sh
		$ROOTDIR/../xfce4-touchpad-indicator/instalar_scripts.sh
		chmod 755 $ROOTDIR/../xfce4-keyboard-shortcuts/instalar.sh
	fi
}

function baseInstall2_x86(){
	if [ $(arch) == "amd64" ]; then
		$ROOTDIR/insts/chrome.sh
		$ROOTDIR/insts/spotify.sh
		$ROOTDIR/insts/skype.sh
	#	$ROOTDIR/insts/discord.sh
	fi

	$ROOTDIR/insts/hp-printer.sh
	$ROOTDIR/insts/firefox.sh
	$ROOTDIR/insts/telegram.sh
	if glxinfo | grep OpenGL | grep intel || glxinfo | grep OpenGL | grep Intel; then
		$ROOTDIR/tweaks/intel-graphics-settings.sh
	fi
	$ROOTDIR/tweaks/fix-ethernet-suspend.sh
}

function baseInstall2_arm(){
        $ROOTDIR/../xfce4-keyboard-shortcuts/instalar.sh
}

function baseInstall2_selector(){
	arq=$(arch)
	if [[ $arq == "aarch64" ]] || [[ $arq == "arm64" ]]; then
		baseInstall2_arm
	elif [[ $arq == "amd64" ]] || [[ $arq == "x86-64" ]] || [[ $arq == "i386" ]] || [[ $arq == "i686" ]] || [[ $arq == "x86_64" ]] ; then
		baseInstall2_x86
	fi
}

## LLAMADAS
if [[ $(lsb_release -si) == "Debian" ]] && \
! dpkg --get-selections | grep lxsession && \
! dpkg --get-selections | grep xfce4-session && \
! dpkg --get-selections | grep plasma-desktop; then
	baseInstall1
else
	baseInstall2_comun
fi
exit 0
