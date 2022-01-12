#!/bin/bash
## REMAPEAR CARPETAS DE XDG A OTRO LUGAR INDICADO (CREA ENLACES SIMBÓLICOS)
## FECHA: 12 de enero de 2022

if [[ ! -z $1 ]]; then
	dir=$(realpath "$1")
	for i in Descargas Documentos Imágenes Música Vídeos; do
		cp -r "$HOME/$i/*" "$dir/$i"
		rm -r "$HOME/$i"
		ln -s "$dir/$i" "$HOME/$i"
	done
fi
