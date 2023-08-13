#!/bin/bash

rm $HOME/.local/share/applications/appimagekit_*-Telegram_Desktop.desktop
rm $HOME/.local/share/applications/telegram*.desktop
rm -r $HOME/.local/share/TelegramDesktop
sudo rm /etc/skel/.local/share/applications/telegram.desktop
sudo rm /usr/local/bin/telegram
sudo rm /usr/local/bin/telegram-desktop
sudo rm -r /opt/Telegram
