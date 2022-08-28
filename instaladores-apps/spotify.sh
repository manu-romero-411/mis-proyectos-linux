#!/bin/bash
## INSTALADOR DE SPOTIFY
## FECHA DE CREACIÓN: 6 de octubre de 2020
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

function instalador(){
	sudo apt-get install -y curl
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee "/usr/share/keyrings/spotify.gpg" >/dev/null
	echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee "/etc/apt/sources.list.d/spotify.list"
	sudo apt-get update
	sudo apt-get install -y spotify-client || error Ha ocurrido algo
}

instalador

exit 0
