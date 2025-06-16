# Overview
This repo contains a collection of scripts to stream audio, video, and video with object detection overlays from a Raspberry Pi to the local network and a couple of cloud services: AWS and YouTube.

# Context
The following is a list of hardware and software used in developing this project.
## Hardware
* [Raspberry Pi 4b (8GB)](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/specifications/)
* [Raspberry Pi Camera Module v2](https://www.raspberrypi.com/products/camera-module-v2/)
* [Raspberry Pi AI Camera](https://www.raspberrypi.com/products/ai-camera/)
## OS options
* [Raspberry Pi OS x64](https://www.raspberrypi.com/software/)
* [Ubuntu 22 LTS](https://releases.ubuntu.com/jammy/)
  * The Raspberry Pi AI Camera is _not_ compatible with Ubuntu 22.
  * We've written our steps to [configure the Camera Module v2 on Ubuntu 22](rpi-av-stream-scripts/CameraModuleV2_Ubuntu22_Setup.md).

# Dependencies and Installation

## System Dependencies
Install the required system packages using your package manager:

```bash
# For Raspberry Pi OS or Ubuntu
sudo apt update
sudo apt install $(cat streaming_scripts/system_requirements.txt | grep -v '^#' | tr '\n' ' ')
```

## Python Dependencies
Install the required Python packages using pip:

```bash
# Create and activate a virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r streaming_scripts/requirements.txt
```

# Streaming procedures
The following sections make use of the scripts in streaming_scripts/
On the Raspberry Pi, navigate to `streaming_scripts/pi`
`cd /path/to/ez-turtlebot/streaming_scripts/pi`

On the PC, navigate to `streaming_scripts/pc`
`cd /path/to/ez-turtlebot/streaming_scripts/pc`


You'll need to set environment variables to use these scripts. I recommend copying the export statements from `pc/bashrc_exports.pc.example` to your `~/.bashrc` on your PC and `pi/bashrc_exports.pi.example` to your `~/.bashrc` on your pi. Remember to source the new bashrc files after you edit them :)

`source ~/.bashrc`

## Stream audio to remote PC
1. On the pi: `./stream_audio_to_pc.sh`
2. On the PC: `./open_audio_stream.sh`

## Stream video to remote PC
1. On the pi: `./stream_video_to_pc.sh`
2. On the PC: `./open_video_stream.sh`

## Stream video to AWS Kinesis
The real leg work for streaming to Kinesis happens on the AWS side, which requires following the [Amazon Kinesis Developer Guide for Raspberry Pi](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/producersdk-cpp-rpi.html). Once you've finished with that guide, you probably won't need this script! Here it is anyway :D
1. On the pi: `./stream_video_to_AWS`

## Stream video with object detection overlays to remote PC
1. On the pi: `python3 stream_object_detection_video_to_pc.py`
2. On the PC: `./open_video_stream.sh`

## Stream video with object detection overlays to YouTube Live
1. You'll need a YouTube channel and you'll need to get that channel approved for streaming. The first time you try to "go live" YouTube will start this approval process.
2. In a web browser, navigate to studio.youtube.com and sign in to your account.
3. "Go Live". If it asks you how you want to go live, e.g., webcam, select the streaming software option.
4. Copy the stream key to the YT_STREAM_KEY variable of your ~/.bashrc and source the ~/.bashrc file.
5. On the pi: `python3 stream_object_detection_video_to_YT.py`
If you want to stream the video with object detection overlays to both YouTube live and the remote PC, use this script _instead_ of the one above:
`python3 stream_object_detection_video_to_both.py`

# Related Projects
This repository was created as part of the [ez-turtlebot3](https://github.com/ez-turtlebot3/ez-turtlebot3) project.
