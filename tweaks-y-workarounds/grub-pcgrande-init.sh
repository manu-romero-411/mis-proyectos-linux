#!/bin/bash
## CONFIGURAR GRUB EN #pcgrande
## FECHA DE CREACIÓN: 3 de septiembre de 2021
## FECHAS DE MODIFICACIÓN: 

function linux_cmd(){
	sed -i s/GRUB_CMDLINE_LINUX_DEFAULT/\#GRUB_CMDLINE_LINUX_DEFAULT/g /etc/default/grub
	sudo su -c 'echo GRUB_CMDLINE_LINUX_DEFAULT=\"pci=noaer\ pcie_aspm=off\ i915.enable_rc6=0\" >> /etc/default/grub'
	update-grub
}

linux_cmd
