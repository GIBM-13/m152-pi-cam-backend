#!/bin/bash

uv4l -nopreview --auto-video_nr --driver raspicam --encoding mjpeg --width 640 --height 480 --framerate 5 --server-option '--port=8080' --server-option '--max-queued-connections=10' --server-option '--max-streams=5' --server-option '--max-threads=29' --rotation 180

#uv4l -nopreview --auto-video_nr --driver raspicam --encoding mjpeg --width 640 --height 480 --framerate 5 --server-option '--port=8554' --server-option '--max-queued-connections=10' --server-option '--max-streams=5' --server-option '--max-threads=29' --rotation 180
