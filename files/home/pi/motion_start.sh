#! /bin/bash
uv4l --driver raspicam --video_nr 0 &>/dev/null &
motion -c /home/pi/motion/mymotion.conf &>/dev/null &

