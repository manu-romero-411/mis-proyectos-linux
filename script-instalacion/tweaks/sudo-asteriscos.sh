#!/bin/bash
## ASTERISCOS EN LA CONTRASEÑA DE SUDO
## FECHA: 18 de mayo de 2020

sed -i s#"env_reset"#"env_reset,pwfeedback"#g /etc/sudoers
sudo -k
