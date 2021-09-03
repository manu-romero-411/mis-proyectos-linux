#!/bin/bash
## ABRIDOR AUTOMÁTICO DE CLASES ONLINE DURANTE LA CUARENTENA DEL COVID-19
## FECHA DE CREACIÓN: 1 de abril de 2020
## FECHAS DE MODIFICACIÓN: 20 de abril de 2020

## Input variable del script más abajo, a partir de línea 39 (cambiar según circunstancia)
 
##############################################################################
### PARTE NO CAMBIABLE HABITUALMENTE (NO TOCAR A NO SER QUE SEA NECESARIO) ###
##############################################################################
function error_handler(){
	errormsg="No hay clase ahora XD"
	if [[ $1 == "ui" ]]; then
		notify-send --icon=dialog-error "ERROR DEL PROGRAMA coronaclases" "$errormsg"
	else
		echo "[ERROR] $errormsg"
	fi
	exit 1
}

function selector_clases(){
	if [ $hora -eq 08 ] && [ $minuto -ge 30 ]; then
		echo $1
	elif [ $hora -eq 09 ] && [ $minuto -lt 30 ]; then
		echo $1
	elif [ $hora -eq 09 ] && [ $minuto -ge 30 ]; then
		echo $2
	elif [ $hora -eq 10 ] && [ $minuto -lt 30 ]; then
		echo $2
	elif [ $hora -eq 10 ] && [ $minuto -ge 30 ]; then
		echo $3
	elif [ $hora -eq 11 ] && [ $minuto -lt 30 ]; then
		echo $3
	elif [ $hora -eq 11 ] && [ $minuto -ge 30 ]; then
		echo $4
	elif [ $hora -eq 12 ] && [ $minuto -lt 30 ]; then
		echo $4
	elif [ $hora -eq 12 ] && [ $minuto -ge 30 ]; then
		echo $5
	elif [ $hora -eq 13 ] && [ $minuto -lt 30 ]; then
		echo $5
	elif [ $hora -eq 13 ] && [ $minuto -ge 30 ]; then
		echo $6
	elif [ $hora -eq 14 ] && [ $minuto -lt 30 ]; then
		echo $6
	fi
}

hora=$(date +%H)
minuto=$(date +%M)
fecha=$(date +%a)

##############################################################
### A PARTIR DE AQUÍ VIENE LA PARTE CAMBIABLE EN UN FUTURO ###
##############################################################

function links(){
	
	### ENLACE DE GOOGLE MEET PARA CONCATENARLO CON LOS IDS DE LAS SALAS
	meet_link="https://meet.google.com/"
	
	case $(selector_clases $clases) in

	## IDs MANU-STYLE DE LAS ASIGNATURAS: XinfY_ZZZ (_prac)
	### X: curso al que pertenece la asignatura (1, 2, 3 ó 4)
	### Y: cuatrimestre de la asignatura (1 ó 2)
	### ZZZ: abreviatura de la asignatura, máximo tres letras
	### Añadiendo _prac al id se distingue entre teoría y prácticas
	
	## LINKS DE LAS ASIGNATURAS DE TEORÍA (sala=<id de la sala que los profesores darán>)
		2inf2_scd) 		sala=vvw-khbw-wbn;;
		2inf2_alg) 		sala=stx-jydn-jmg;;
		2inf2_dbf) 		sala=npt-oxjf-usr;;
		2inf2_red) 		sala=ksu-rieb-nvs;;
		2inf2_ia) 		sala=tmj-unzx-bbb;;
	
	## LINKS DE LAS ASIGNATURAS DE PRÁCTICAS (sala=<id de la sala que los profesores darán>)
		2inf2_scd_prac) sala=;;
		2inf2_alg_prac) sala=cjv-bezh-hmu;;
		2inf2_dbf_prac) sala=npt-oxjf-usr;;
		2inf2_red_prac) sala=;;
		2inf2_ia_prac)	sala=;;
		
	## QUERER TENER CLASE PERO NO ES LA HORA XD
		*) 			error_handler ui;;
	esac
	echo ${meet_link}${sala}
}

function horario(){
	#########################################################################################################################################
	### HORARIO DE CLASES            8:30 A 9:30       9:30 A 10:30      10:30 A 11:30     11:30 A 12:30    12:30 A 13:30     13:30 A 14:30 #

	[[ $fecha == "lun" ]] && clases="null              2inf2_alg         2inf2_dbf         2inf2_red        null              null"
	[[ $fecha == "mar" ]] && clases="null              2inf2_alg         2inf2_scd         2inf2_ia         2inf2_red         null"
	[[ $fecha == "mié" ]] && clases="null              2inf2_scd         2inf2_dbf         2inf2_ia         null              null"
	[[ $fecha == "jue" ]] && clases="2inf2_scd_prac    2inf2_scd_prac    2inf2_red_prac    2inf2_red_prac   2inf2_alg_prac    2inf2_alg_prac"
	[[ $fecha == "vie" ]] && clases="2inf2_ia_prac     2inf2_ia_prac     2inf2_dbf_prac    2inf2_dbf_prac   null              null"

	#########################################################################################################################################
}

###########################################################################
## INVOCADOR DE LAS FUNCIONES QUE GENERAN EL LINK DE LA CLASE (NO TOCAR) ##
###########################################################################

horario
links $horario
exit 0
