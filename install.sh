#!/bin/bash

##########################################
## @Author:	Patrick Reimers		##
## @Version:	2016-05-10		##
##########################################

###
# Sicherstellen, dass Dash deaktiviert ist
###

sudo dpkg-reconfigure dash;

echo -e "\e[32m--------------";
echo -e "\e[32mBash aktiviert";
echo -e "\e[32m--------------\e[0m";

###
# System Config setzen
###

echo -e "\e[32m--------------------------";
echo -e "\e[32mRaspberry Pi Konfigurieren";
echo -e "\e[32m--------------------------\e[0m";

echo -e "\e[32m----------------------------";
echo -e "\e[32mBitte die Kammera aktivieren";
echo -e "\e[32m  und die Zeitzone setzen";
echo -e "\e[32m----------------------------\e[0m";

sleep 2; # Sleep von 2 Sekunden, damit der Nutzer die Informationen lesen kann.

sudo raspi-config

###
# Repos & System updaten/upgraden
###

echo -e "\e[32m----------------------------";
echo -e "\e[32mSystem wird aktualisiert und";
echo -e "\e[32m  benötigtige Komponenten";
echo -e "\e[32m    werden Installiert";
echo -e "\e[32m----------------------------\e[0m";

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get install vim-nox nano git -y;

###
# Config vom git laden und auf das System kopieren
###

echo -e "\e[32m---------------------------";
echo -e "\e[32mDaten werden heruntergeaden";
echo -e "\e[32m---------------------------\e[0m";

cd /tmp;
git clone https://github.com/GIBM-13/m152-pi-cam-backend.git pi-cam-files;
sudo cp -R /tmp/pi-cam-files/files/etc/apt/* /etc/apt/;

echo -e "\e[32m--------------------------";
echo -e "\e[32mInstalliere PHP7 und NGINX";
echo -e "\e[32m--------------------------\e[0m";

sudo apt-get update && sudo apt-get install -t stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip nginx;

sudo cp -R /tmp/pi-cam-files/files/* /;

echo -e "\e[32m--------------------------";
echo -e "\e[32mInstallation abgeschlossen";
echo -e "\e[32m--------------------------\e[0m";

###
# System neustarten
###

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32mDas System wird neugestartet";
echo -e "\e[32m----------------------------\e[0m";

sudo shutdown -r now
exit;
