#!/bin/bash
## INSTALADOR DE BRAVE
## FECHA: 17 de mayo de 2020

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
sudo apt-get install -y apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --dearmor | sudo tee /usr/share/keyrings/brave-browser-release.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/brave-browser-release.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null
sudo apt-get update || error Fallo al actualizar
sudo apt-get install -y brave-browser || error Fallo al instalar
exit 0
