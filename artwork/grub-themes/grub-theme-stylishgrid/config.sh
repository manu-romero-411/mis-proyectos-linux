#!/bin/bash

PCACTUAL=default

function detectar_pc(){
	case $(cat /sys/devices/virtual/dmi/id/board_name) in
		X541UJ) PCACTUAL=pcgrande;;
		82A9) PCACTUAL=pcazul;;
		"NPVAA DDR3") PCACTUAL=armatoste;;
		*) PCACTUAL=default;;
	esac
}

detectar_pc
mv "/boot/grub/grub-theme-stylishgrid/background-term-$PCACTUAL.png" "/boot/grub/bg.png"
mv "/boot/grub/grub-theme-stylishgrid/background-$PCACTUAL.png" "/boot/grub/grub-theme-stylishgrid/background.png"
