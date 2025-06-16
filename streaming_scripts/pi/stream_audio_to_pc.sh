#!/bin/bash

# Starts the audio stream from the USB microphone using GStreamer
#
# USAGE:
#   1. Copy ~/.bashrc_exports.pi.example to ~/.bashrc and modify the variables as needed
#   2. Run the script:
#      ./stream_audio_to_pc.sh

# GStreamer pipeline to capture audio from the microphone and send it to the remote PC
gst-launch-1.0 -v \
	alsasrc device="${AUDIO_DEVICE}" ! \
	"audio/x-raw, format=S16LE, rate=48000, channels=1" ! \
	audioconvert ! \
	audioresample ! \
	"audio/x-raw,channels=1" ! \
	opusenc bitrate=16000 ! \
	rtpopuspay ! \
	udpsink host="${REMOTE_PC_IP}" port="${AUDIO_UDP_PORT}"
