#!/bin/bash

##########################################
## @Author:     Patrick Reimers         ##
## @Version:    2016-05-10              ##
##########################################

echo -e "\e[32m-----------------------";
echo -e "\e[32mBitte Dash deaktivieren";
echo -e "\e[32m  wählen Sie nein/no";
echo -e "\e[32m-----------------------\e[0m";

sleep 5; # Sleep von 5 Sekunden, damit der Nutzer die Informationen lesen kann

sudo dpkg-reconfigure dash;

echo "";
echo -e "\e[32m--------------------------";
echo -e "\e[32mRaspberry Pi Konfigurieren";
echo -e "\e[32m--------------------------\e[0m";

echo "";
echo -e "\e[32m---------------------------";
echo -e "\e[32mBitte die Kamera aktivieren";
echo -e "\e[32m  und die Zeitzone setzen";
echo -e "\e[32m---------------------------\e[0m";

sleep 5; # Sleep von 5 Sekunden, damit der Nutzer die Informationen lesen kann

sudo raspi-config

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m  Netwerk Proxy einrichten";
echo -e "\e[32m----------------------------\e[0m";

echo "Proxy (yes/no)";
read proxy;

if [ "$proxy" = "yes" ]
then
        echo "Adresse:";
        read adress;

        echo "Port:":
        read port;

        echo "Username:";
        read user;

        echo "Passwort:";
        read -s pass;

        use_proxy=$proxy;
        http_proxy="http://$user:$pass@$adress:$port";
        https_proxy="https://$user:$pass@$adress:$port";

        export use_proxy;
        export http_proxy;
        export https_proxy;

        sudo echo "-------------------------------------" | sudo tee --append /etc/environment;
        sudo echo "#Proxy" | sudo tee --append /etc/environment;
        sudo echo "-------------------------------------" | sudo tee --append /etc/environment;
        sudo echo "use_proxy=\"$proxy\";" | sudo tee --append /etc/environment;
        sudo echo "http_proxy=\"http://$user:$pass@$adress:$port\";" | sudo tee --append /etc/environment;
        sudo echo "https_proxy=\"https://$user:$pass@$adress:$port\";" | sudo tee --append /etc/environment;

        sudo echo "export use_proxy;" | sudo tee --append /etc/environment;
        sudo echo "export http_proxy;" | sudo tee --append /etc/environment;
        sudo echo "export https_proxy;" | sudo tee --append /etc/environment;
fi


echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32mSystem wird aktualisiert und";
echo -e "\e[32m  benötigtige Komponenten";
echo -e "\e[32m    werden Installiert";
echo -e "\e[32m----------------------------\e[0m";

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get install vim-nox nano git curl -y && sudo apt-get autoremove -y && apt-get moo;

echo "";
echo -e "\e[32m---------------------------";
echo -e "\e[32mDaten werden heruntergeaden";
echo -e "\e[32m---------------------------\e[0m";

cd /tmp;
git clone https://github.com/GIBM-13/m152-pi-cam-backend.git pi-cam-files;
sudo cp -R /tmp/pi-cam-files/files/etc/apt/* /etc/apt/;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m Installiere PHP7 und NGINX";
echo -e "\e[32m----------------------------\e[0m";

curl http://www.linux-projects.org/listing/uv4l_repo/lrkey.asc | sudo apt-key add -;
sudo apt-get update && sudo apt-get install -t stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip nginx -y;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m      Installiere UV4L";
echo -e "\e[32m----------------------------\e[0m";

sudo apt-get install uv4l uv4l-raspicam -y;
sudo apt-get install uv4l-raspicam-extras -y;
sudo apt-get install uv4l-server -y;
sudo apt-get install uv4l-uvc -y;
sudo apt-get install uv4l-xscreen -y;
sudo apt-get install uv4l-mjpegstream -y;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m     Installiere motion";
echo -e "\e[32m----------------------------\e[0m";

sudo apt-get install motion -y;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m   Dateien werden kopiert";
echo -e "\e[32m----------------------------\e[0m";

sudo cp -R /tmp/pi-cam-files/files/* /;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m   NGINX wird konfiguriert";
echo -e "\e[32m----------------------------\e[0m";

cd /etc/nginx/sites-enabled/;
sudo rm default;
sudo ln -s ../sites-available/pi-cam;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m        Rechte setzen";
echo -e "\e[32m----------------------------\e[0m";

sudo chmod a+x /home/pi/*.sh;
sudo chown -R pi:pi /home/pi/;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32m Installation abgeschlossen";
echo -e "\e[32m----------------------------\e[0m";

sleep 2;

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32mDas System wird neugestartet";
echo -e "\e[32m----------------------------\e[0m";

sleep 5; #Sleep von 5 Sekunden, damit der Nutzer die Informationen lesen kann

sudo shutdown -r now;
exit;
