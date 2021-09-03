#!/bin/bash
## SCRIPT PARA AUTOCONFIGURAR LA GRÁFICA NVIDIA EN BASE AL #pcgrande
## FECHA DE CREACIÓN: 14 de febrero de 2020
## FECHAS DE MODIFICACIÓN: 16 de febrero de 2020, 28 de febrero de 2020

## GESTOR DE EXCEPCIONES

function error(){
	echo "[ERROR] Algo ha ocurrido. F."
	exit 1
}

## PRELIMINARMENTE, HAY QUE COMPROBAR SI SOMOS ROOT
if [[ $(whoami) != "root" ]]; then
	echo "TOONTO, QUE ERES TOONTO, DEL TOOO, NO PA UN RATO, NO, TONTO DEL TOOO, PA SIEMPRE, VAYA UN NO ROOT HARTOSOPAS" 
	error
fi

function ubuntu_nvidia(){
	## LO PRIMERO ES PONER EL STACK GRÁFICO ORIGINAL, QUE NO EL HWE
	echo "[INFO] Instalando stack gráfico LTS..."
	apt-get install -y xserver-xorg-core xserver-xorg xserver-xorg-video-intel xserver-xorg-video-vesa xserver-xorg-video-fbdev xserver-xorg-input-all xserver-xorg-input-mouse --autoremove --purge || error

	## AHORA A BORRAR EL DRIVER NOUVEAU
	echo "[INFO] Desinstalando el driver Nouveau..."
	apt-get autoremove --purge xserver-xorg-video-nouveau* || error

	## AHORA A INSTALAR LOS DRIVERS PRIVATIVOS
	echo "[INFO] Instalando drivers privativos..."
	apt-get -y install linux-headers-generic
	ubuntu-drivers autoinstall || error

	# SE VA A DESCONSIDERAR LA POSIBILIDAD DE PONER BUMBLEBEE EN UBUNTU DADA SU ALTA INESTABILIDAD. LO QUE SÍ HAY QUE HACER ES EL WORKAROUND PARA CAMBIAR DE LA INTEL A LA NVIDIA A LA VEZ QUE SE HACE LA DEFINICIÓN 20-intel.conf PARA CORREGIR EL TEARING, JUNTO AL WORKAROUND PARA SOLUCIONAR EL GHOSTING DEL RATÓN CON LA NVIDIA FUNCIONANDO.

}

function debian_nvidia(){
	raiz=$(dirname .)
	# ¿BACKPORTS?
	if [[ $1 == "backports" ]]; then
		backports="-t buster-backports"
	else
		backports=
	fi

	# SE DESINSTALA EL CONTROLADOR NOUVEAU
	apt-get -y autoremove --purge xserver-xorg-video-nouveau

	# SE PONE EN BLACKLIST EL NOUVEAU PORZIACAZO
	cp $raiz/files/blacklist-nouveau.conf /etc/modprobe.d
	chmod 644 /etc/modprobe.d/blacklist-nouveau.conf

	# INSTALACIÓN DEL DRIVER Y DE BUMBLEBEE
	echo "[INFO] Instalando bumblebee..."
	apt-get install -y $backports linux-headers-amd64 
	apt-get install -y $backports nvidia-driver
	#apt-get install -y $backports bumblebee bumblebee-nvidia primus || error

	# COLOCAREMOS UNA VARIABLE EN EL ENVIRONMENT
	grep "__GLVND_DISALLOW_PATCHING=1" /etc/environment || echo "__GLVND_DISALLOW_PATCHING=1" >> /etc/environment


	## CONFIGURAREMOS LA RUTA A LAS LIBRERÍAS GRÁFICAS POR PARTE DE BUMBLEBEE
	sed -i s#/usr/lib/x86_64-linux-gnu/nvidia:/usr/lib/i386-linux-gnu/nvidia:/usr/lib/nvidia#/usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu#g /etc/bumblebee/bumblebee.conf
	sed -i s#/usr/lib/nvidia-current/xorg,/usr/lib/xorg/modules#/usr/lib/x86_64-linux-gnu/nvidia/xorg,/usr/lib/xorg/modules,/usr/lib/xorg/modules/input#g /etc/bumblebee/bumblebee.conf

	## MÓDULOS DEL KERNEL EN LISTA NEGRA
	[ -f /etc/modprobe.d/blacklist-nvidia.conf ] && rm /etc/modprobe.d/blacklist-nvidia.conf
	echo "blacklist nvidia" > /etc/modprobe.d/blacklist-nvidia.conf
	echo "blacklist nvidia-drm" >> /etc/modprobe.d/blacklist-nvidia.conf
	echo "blacklist nvidia-modeset" >> /etc/modprobe.d/blacklist-nvidia.conf
	echo >> /etc/modprobe.d/blacklist-nvidia.conf
	echo "#alias nvidia off" >> /etc/modprobe.d/blacklist-nvidia.conf
	echo "alias nvidia-drm off" >> /etc/modprobe.d/blacklist-nvidia.conf
	echo "#alias nvidia-modeset off" >> /etc/modprobe.d/blacklist-nvidia.conf


	## ESTABLECEMOS UNA DIRECTIVA DE PANTALLA EN X11 PARA QUE NO HAYA PROBLEMAS

	if ! grep "Section \"Screen\"" /etc/bumblebee/xorg.conf.nvidia; then
		echo " "
		echo "Section \"Screen\"" >> /etc/bumblebee/xorg.conf.nvidia
		echo "        Identifier \"Default Screen\"" >> /etc/bumblebee/xorg.conf.nvidia
		echo "        Device \"DiscreteNvidia\"" >> /etc/bumblebee/xorg.conf.nvidia
		echo "EndSection" >> /etc/bumblebee/xorg.conf.nvidia
	fi

	## PONEMOS ADECUADAMENTE LAS LIBRERÍAS GRÁFICAS
	for i in x86_64-linux-gnu i386-linux-gnu; do
		if [[ ! -d "/usr/lib/$i/mesa/" ]]; then
			mkdir "/usr/lib/$i/mesa/"
			ln -s "/usr/lib/$i/libGL.so.1.0.0" "/usr/lib/$i/mesa/libGL.so.1" || ln -s "/usr/lib/$i/libGL.so.1" "/usr/lib/$i/mesa/libGL.so.1"
		fi
		if [[ ! -d "/usr/lib/$i/nvidia/" ]]; then
			mkdir "/usr/lib/$i/nvidia/"
		fi
		ln -s "/usr/lib/$i/libGL.so.1.0.0" "/usr/lib/$i/nvidia/libGL.so.1" || ln -s "/usr/lib/$i/libGL.so.1" "/usr/lib/$i/nvidia/libGL.so.1" 
	done
}

if [[ $(lsb_release -si) == "Ubuntu" ]]; then
	ubuntu_nvidia
elif [[ $(lsb_release -si) == "Debian" ]]; then
	debian_nvidia $1
fi

