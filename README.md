[![Stories in Ready](https://badge.waffle.io/GIBM-13/m152-pi-cam-backend.png?label=ready&title=Ready)](https://waffle.io/GIBM-13/m152-pi-cam-backend) [![Join the chat at https://gitter.im/GIBM-13/m152-pi-cam-backend](https://badges.gitter.im/GIBM-13/m152-pi-cam-backend.svg)](https://gitter.im/GIBM-13/m152-pi-cam-backend?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Raspberry Pi Cam backend
Backend for [Module 152](http://m152.iet-gibb.ch/diverses/ml152-fs_2016.pdf) Raspberry Pi Security Cam project.

## Requirements
* Raspberry Pi B 1, 2 or 3
* Original HD-Camera for Raspberry Pi

## Installation
Run the following comands and follow the instructions below:
```
cd /tmp
wget https://raw.githubusercontent.com/GIBM-13/m152-pi-cam-backend/master/install.sh
chmod +x install.sh
./install.sh
```
or 
```
cd /tmp
wget https://raw.githubusercontent.com/GIBM-13/m152-pi-cam-backend/master/install.sh -e use_proxy=yes -e https_proxy=https://[username]:[password]@[IP]:[port]
chmod +x install.sh
./install.sh
```


1. Select `no` _(we are using bash instead of dash)_
2. Activate the camera & do the some general raspberry pi configuration (set locale / set timezone / ..)
3. __DO NOT reboot__ it will reboot after the script is finished

## How to

### Start / stop scripts
Start motion: `sh /home/pi/motion.sh`

Start stream: `sh /home/pi/stream.sh`

Stop all: `sh /home/pi/stop.sh`

### motion image/video dir
motion saves images on motiondetect in: `/home/pi/www/media`

### Webcam stream
The Webcam stream runs on port: __8554__

### Webserver
The web document root is located under: `/home/pi/www`
