#!/bin/bash
## INSTALADOR DE ANYDESK
## FECHA DE CREACIÓN: 9 de enero de 2022
## FECHAS DE MODIFICACIÓN: 28 de agosto de 2022

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

#check_root
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor | sudo tee /usr/share/keyrings/anydesk.gpg  >/dev/null
echo "deb [signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list >/dev/null
sudo apt-get update || error Fallo al actualizar
sudo apt-get install -y anydesk || error Fallo al instalar
exit 0
