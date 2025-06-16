#!/bin/bash

# Opens the audio stream from the Raspberry Pi using GStreamer
#
# USAGE:
#   1. In the Raspberry Pi, start the audio stream
#   2. In the remote pc, copy .bashrc_exports.pc.example to ~/.bashrc and modify the variables as needed
#   3. In the remote pc, run the script:
#      ./open_audio_stream.sh

# GStreamer pipeline to receive audio from the Raspberry Pi and play it using playbin
gst-launch-1.0 -v \
	udpsrc port="${AUDIO_UDP_PORT}" caps="application/x-rtp, media=(string)audio, clock-rate=(int)48000, encoding-name=(string)OPUS, payload=(int)96" ! \
	rtpopusdepay ! \
	opusdec ! \
	audioconvert ! \
	audioresample ! \
	autoaudiosink
