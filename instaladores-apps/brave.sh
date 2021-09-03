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

check_root
apt install -y apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - || error
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list || error
apt update || error
apt install -y brave-browser || error
exit 0
