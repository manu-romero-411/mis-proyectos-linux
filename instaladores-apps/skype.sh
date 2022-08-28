#!/bin/bash
## INSTALADOR DE CHROME
## FECHA DE CREACIÓN: 23 de octubre de 2020
## FECHAS DE MODIFICACIÓN: 28 de agosto de 2022

## VARIABLES

ROOTDIR=$(realpath $(dirname $0))
FLATPAK_ID=com.skype.Client

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

function instalador(){
        SKYPEDEB="$(mktemp)"
        wget -O $SKYPEDEB 'https://go.skype.com/skypeforlinux-64.deb' &&  dpkg -i "$SKYPEDEB"
        apt-get -f -y install || error Ha ocurrido un error
        rm -f "$SKYPEDEB"
        SKYPE_GPG_LINEA=$(($(apt-key list 2>/dev/null | grep -wn Skype | cut -d":" -f1) - 1))
        SKYPE_GPG_1=$(apt-key list 2>/dev/null | head -n $SKYPE_GPG_LINEA | tail -n 1 | rev | cut -d" " -f2 | rev)
        SKYPE_GPG_2=$(apt-key list 2>/dev/null | head -n $SKYPE_GPG_LINEA | tail -n 1 | rev | cut -d" " -f1 | rev)
        echo $SKYPE_GPG_LINEA $SKYPE_GPG_1 $SKYPE_GPG_2
        apt-key export ${SKYPE_GPG_1}${SKYPE_GPG_2} | gpg --dearmour > /tmp/skype.gpg
        apt-key del ${SKYPE_GPG_1}${SKYPE_GPG_2}
        [[ ! -f "/usr/share/keyrings/skype.gpg" ]] &&  mv "/tmp/skype.gpg" "/usr/share/keyrings/skype.gpg"
        echo "deb [signed-by=/usr/share/keyrings/skype.gpg arch=amd64] https://repo.skype.com/deb stable main" |  tee /etc/apt/sources.list.d/skype-stable.list
        apt-get update
        cp $ROOTDIR/post-install-configs/skype/skype-gpg-fix /usr/local/bin/skype-gpg-fix
        chmod 755 /usr/local/bin/skype-gpg-fix
}

function flatpak_inst(){
	if ! dpkg --get-selections | grep flatpak; then
		$ROOTDIR/flatpak.sh
	fi
	flatpak install -y flathub $FLATPAK_ID
}

function desinstalar(){
	if dpkg --get-selections | grep flatpak; then
		flatpak uninstall -y $FLATPAK_ID
		flatpak uninstall -y --unused
	fi
	apt-get -y autoremove --purge skypeforlinux
	rm "/usr/share/keyrings/skype.gpg"
	rm "/etc/apt/sources.list.d/skype-stable.list"
}

## LLAMADAS

check_root
if [[ $1 == "-d" ]]; then
	desinstalar
elif [[ $1 == "-nf" ]]; then
	instalador
else
	flatpak_inst
fi

exit 0
