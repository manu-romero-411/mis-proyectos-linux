#!/bin/bash

## BORRAR ATAJOS QUE PUEDA YA HABER
for i in $(xfconf-query -c xfce4-keyboard-shortcuts -l | tr "\n" " "); do
	if echo $i | grep "commands"; then
		xfconf-query -c xfce4-keyboard-shortcuts -p "$i" -r
	fi
done
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>d" -r

## AÑADIR ATAJOS NUEVOS

