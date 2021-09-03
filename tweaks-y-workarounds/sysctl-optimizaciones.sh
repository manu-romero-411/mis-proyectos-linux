#!/bin/bash
## SCRIPT PARA APLICAR CIERTAS OPTIMIZACIONES AL SISTEMA
## FECHA DE CREACIÓN: Desconocida
## FECHAS DE MODIFICACIÓN: 23 de octubre de 2020

# DESHABILITAR BLUETOOTH AL INICIO
gsettings set org.blueman.plugins.powermanager auto-power-on false

# ARREGLAR SWAP Y CACHÉ
sudo sh -c "echo 'vm.swappiness=1' >> /etc/sysctl.conf"
sudo sh -c "echo 'vm.vfs_cache_pressure=50' >> /etc/sysctl.conf"
sudo sysctl -p

## OPTIMIZACIONES INTEL
#cp $ROOTDIR/files/intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf

# TODO: METER SCRIPTS DE GITHUB EN /usr/local/bin
