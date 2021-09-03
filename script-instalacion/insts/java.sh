#!/bin/bash
## SCRIPT PARA INSTALAR JDK11 Y NETBEANS 
## FECHA DE CREACIÓN: 16 de febrero de 2020
## FECHA DE MODIFICACIÓN: 23 de junio de 2020, 6 de octubre de 2020

JAVAVER=11.0.8

function error(){
	echo "[ERROR] Algo ha ocurrido. F."
	exit 1
}

if [[ $(whoami) != "root" ]]; then
	echo "No eres root."
	error
fi

if [[ -f "../files/jdk-${JAVAVER}_linux-x64_bin.deb" ]]; then
	apt-get install "../files/jdk-${JAVAVER}_linux-x64_bin.deb" || error
else
	echo "[F] No está el instalador de Java en la carpeta $(realpath $(dirname $0)/..)/files. Mételo ahí"
	error
fi

! grep JAVA_HOME /etc/environment && echo JAVA_HOME="/usr/lib/jvm/jdk-${JAVAVER}/" >> /etc/environment
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-${JAVAVER}/bin/java" 0
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-${JAVAVER}/bin/javac" 0
update-alternatives --set java "/usr/lib/jvm/jdk-${JAVAVER}/bin/java"
update-alternatives --set javac "/usr/lib/jvm/jdk-${JAVAVER}/bin/javac"

#../files/netbeans.sh || error

exit 0
