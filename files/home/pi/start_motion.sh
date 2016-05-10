#!/bin/bash

##########################################
## @Author:     Patrick Reimers         ##
## @Version:    2016-05-10              ##
##########################################

if [ -e /dev/video1 ];
then
        LD_PRELOAD=/usr/lib/uv4l/uv4lext/armv6l/libuv4lext.so motion -c /home/pi/motion/motion_video1.conf;
else
        LD_PRELOAD=/usr/lib/uv4l/uv4lext/armv6l/libuv4lext.so motion -c /home/pi/motion/motion_video0.conf;
fi;
