#!/bin/bash

##########################################
## @Author:	Patrick Reimers		##
## @Version:	2016-05-10		##
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
echo -e "\e[32m--------------------------";
echo -e "\e[32mInstalliere PHP7 und NGINX";
echo -e "\e[32m--------------------------\e[0m";

curl http://www.linux-projects.org/listing/uv4l_repo/lrkey.asc | sudo apt-key add -;
sudo apt-get update && sudo apt-get install -t stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip nginx -y;

echo "";
echo -e "\e[32m----------------";
echo -e "\e[32mInstalliere UV4L";
echo -e "\e[32m----------------\e[0m";

sudo apt-get install uv4l -y;
sudo apt get install uv4l-raspicam -y;
sudo apt-get install uv4l-raspicam-extras -y;
sudo apt-get install uv4l-server -y;
sudo apt-get install uv4l-uvc -y;
sudo apt-get install uv4l-xscreen -y;
sudo apt-get install uv4l-mjpegstream -y;

echo "";
echo -e "\e[32m------------------";
echo -e "\e[32mInstalliere ffmpeg";
echo -e "\e[32m------------------\e[0m";

#cd /tmp;
#wget https://github.com/ccrisan/motioneye/wiki/precompiled/ffmpeg_2.8.3.git325b593-1_armhf.deb;
#sudo dpkg -i ffmpeg_2.8.3.git325b593-1_armhf.deb;
#sudo apt-get remove libavcodec-extra-56 libavformat56 libavresample2 libavutil54 -y && sudo apt-get install libavutil54 libavformat56 libswscale3 -y;

sudo apt-get install -t stretch ffmpeg libavdevice-ffmpeg56 libavfilter-ffmpeg5 libavformat-ffmpeg56 libgnutls30

echo "";
echo -e "\e[32m------------------";
echo -e "\e[32mInstalliere motion";
echo -e "\e[32m------------------\e[0m";

sudo apt-get install motion -y;

cd /tmp;
sudo wget https://github.com/ccrisan/motioneye/wiki/precompiled/motion-mrdave-raspbian -O /usr/local/bin/motion;
sudo chmod +x /usr/local/bin/motion;
sudo mkdir /home/pi/motion
sudo mkdir /var/www/html/videos
sudo chown pi:pi /var/www/html/videos
sudo chmod 750 /var/www/html/videos
sudo cp /etc/motion/motion.conf /home/pi/motion/mymotion.conf
sudo cp mymotion.conf mymotion.orig
sudo chown pi:pi mymotion.conf
uv4l --driver raspicam --video_nr 0
LD_PRELOAD=/usr/lib/uv4l/uv4lext/armv6l/libuv4lext.so
motion -c /home/pi/motion/mymotion.conf


echo "";
echo -e "\e[32m----------------------";
echo -e "\e[32mDateien werden kopiert";
echo -e "\e[32m----------------------\e[0m";

sudo cp -R /tmp/pi-cam-files/files/* /;

echo "";
echo -e "\e[32m-----------------------";
echo -e "\e[32mNGINX wird konfiguriert";
echo -e "\e[32m-----------------------\e[0m";

cd /etc/nginx/sites-enabled/;
sudo rm default;
sudo ln -s ../sites-available/pi-cam;

echo "";
echo -e "\e[32m-------------------------";
echo -e "\e[32mUV4L treiber wird geladen";
echo -e "\e[32m-------------------------\e[0m";

uv4l --driver raspicam --auto-video_nr;

echo "";
echo -e "\e[32m-------------";
echo -e "\e[32mRechte setzen";
echo -e "\e[32m-------------\e[0m";

sudo chmod a+x /home/pi/start_motion.sh;
sudo chmod a+x /home/pi/stop_motion.sh;
sudo chown -R pi:pi /home/pi/;

echo "";
echo -e "\e[32m--------------------------";
echo -e "\e[32mInstallation abgeschlossen";
echo -e "\e[32m--------------------------\e[0m";

# sudo apt-get install -t stretch ffmpeg libavdevice-ffmpeg56 libavfilter-ffmpeg5 libavformat-ffmpeg56 libopencv-core2.4v5 libopencv-imgproc2.4v5 libgnutls30

echo "";
echo -e "\e[32m----------------------------";
echo -e "\e[32mDas System wird neugestartet";
echo -e "\e[32m----------------------------\e[0m";

sleep 5; #Sleep von 5 Sekunden, damit der Nutzer die Informationen lesen kann

sudo shutdown -r now
exit;