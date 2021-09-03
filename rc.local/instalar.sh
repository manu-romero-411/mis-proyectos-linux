#!/bin/bash
## REHABILITADOR DE rc.local
## FECHA: 11 de abril de 2021

ROOTDIR=$(realpath $(dirname $0))

function error(){
	echo "[ERROR] $@. F"
	exit 1
}

function root(){
	if [[ $(whoami) != "root" ]]; then
		error No eres root
	fi
}

root
cp "$ROOTDIR/rc-local.service" /lib/systemd/system || error Fallo al copiar rc-local.service
chmod 644 /lib/systemd/system/rc-local.service
cp "$ROOTDIR/rc.local" /etc/rc.local || error Fallo al copiar rc.local
chmod 755 /etc/rc.local

systemctl enable rc-local || error Fallo al habilitar servicio
systemctl start rc-local || error Fallo al iniciar servicio
exit 0
