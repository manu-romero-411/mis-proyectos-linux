#!/bin/bash
## CONFIGURADOR DE PARÁMETROS DE ENERGÍA CON POWERTOP
## AUTOR: DESCONOCIDO
## FECHA DE CREACIÓN: Desconocida
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020,

if dpkg --get-selections powertop; then
	powertop --auto-tune
	HIDDEVICES=$(ls /sys/bus/usb/drivers/usbhid | grep -oE '^[0-9]+-[0-9\.]+' | sort -u)
	for i in $HIDDEVICES; do
		echo -n "Enabling " | cat - /sys/bus/usb/devices/$i/product
  		echo 'on' > /sys/bus/usb/devices/$i/power/control
	done
else
	exit 1
fi
exit 0
