#!/bin/bash

# Stops video streams from the Raspberry Pi Camera Module
#
# USAGE:
#   ./stop_video_stream.sh
#
# This script will stop any running GStreamer pipelines that use:
#   - libcamerasrc (for streaming_scripts/pi/stream_video_to_pc.sh)
#   - kvssink (for streaming_scripts/pi/stream_video_to_AWS.sh)
#   - Any other gst-launch-1.0 video streams
#
# And any ffmpeg processes that use:
#   - YouTube Live streaming (RTMP)
#   - Remote PC streaming (RTP/UDP)

echo "Stopping all video streams..."

# Kill all types of video streams
pkill -f "gst-launch-1.0.*libcamerasrc"
pkill -f "gst-launch-1.0.*kvssink"
pkill -f "gst-launch-1.0.*v4l2src"
pkill -f "ffmpeg.*rtmp://a.rtmp.youtube.com/live2"
pkill -f "ffmpeg.*rtp://"

# Check if any streams were actually stopped
if pgrep -f "gst-launch-1.0.*libcamerasrc" >/dev/null ||
	pgrep -f "gst-launch-1.0.*kvssink" >/dev/null ||
	pgrep -f "gst-launch-1.0.*v4l2src" >/dev/null ||
	pgrep -f "ffmpeg.*rtmp://a.rtmp.youtube.com/live2" >/dev/null ||
	pgrep -f "ffmpeg.*rtp://" >/dev/null; then
	echo "Some video streams could not be stopped."
else
	echo "All video streams successfully stopped."
fi
