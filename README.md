# 🎥 Raspberry Pi Audio/Video Streaming Scripts

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Raspberry Pi](https://img.shields.io/badge/Platform-Raspberry%20Pi-red.svg)](https://www.raspberrypi.com/)
[![OS: Raspberry Pi OS](https://img.shields.io/badge/OS-Raspberry%20Pi%20OS-green.svg)](https://www.raspberrypi.com/software/)
[![OS: Ubuntu 22.04](https://img.shields.io/badge/OS-Ubuntu%2022.04-orange.svg)](https://ubuntu.com/)
[![Python: 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://python.org/)

> **Stream audio, video, and AI-powered object detection from your Raspberry Pi to local networks and cloud services**

A collection of scripts for streaming multimedia content from Raspberry Pi devices. Support for local network streaming, AWS Kinesis, and YouTube Live with real-time object detection capabilities.

## 🚀 Features

- **🎵 Audio Streaming** - Stream audio to remote PCs over local network
- **📹 Video Streaming** - High-quality video streaming with multiple codec options
- **🤖 AI Object Detection** - Real-time object detection with overlay streaming
- **☁️ Cloud Integration** - Stream to AWS Kinesis and YouTube Live
- **🔄 Multi-Destination** - Stream to multiple destinations simultaneously
- **⚡ Low Latency** - Optimized for real-time applications

## 📋 Table of Contents

- [Hardware Requirements](#-hardware-requirements)
- [Software Requirements](#-software-requirements)
- [Set Up Instructions](#-set-up-instructions)
- [Example Uses](#-example-uses)
- [Streaming Options](#-streaming-options)
- [Contributing](#-contributing)
- [Related Projects](#-related-projects)
- [License](#-license)

## 🔧 Hardware Requirements

### Minimum Requirements
- **Raspberry Pi** - Any model (tested on Pi 4B)
- **Camera Module** - Any Raspberry Pi camera module (tested on Camera Module v2 and AI Camera)
- **USB Microphone** - For audio streaming capabilities

### Tested Hardware
> **💡 Development Setup:** These scripts were developed and tested using:
> - Raspberry Pi 4B (8GB)
> - Camera Module v2 and AI Camera
> - Generic USB microphone
> - Both Raspberry Pi OS x64 and Ubuntu 22.04 LTS

> **⚠️ Compatibility Note:** The Raspberry Pi AI Camera is **not compatible** with Ubuntu 22.04. Use the Camera Module v2 instead. We have a setup guide 📖 [Camera Module v2 Ubuntu 22.04 Setup Guide](CameraModuleV2_Ubuntu22_Setup.md)

## 💻 Software Requirements

### Raspberry Pi Operating Systems

**Recommended for Raspberry Pi:**
- **Raspberry Pi OS Lite (64-bit)** - Minimal installation, perfect for headless streaming
- **Ubuntu 22.04 LTS Server** - Alternative option for advanced users

> **💡 Installation Tip:** Use the [Raspberry Pi Imager](https://www.raspberrypi.com/software/) to install either OS on your microSD card. The Imager handles all the setup automatically!

### Remote PC Operating System

**For receiving streams on your PC:**
- **Ubuntu 22.04 LTS** (recommended) - Tested and documented
- **Other Linux distributions** - Should work with minor adjustments
- **Windows/macOS** - May require different video player setup

### System Dependencies

The following packages are installed during setup.

#### Raspberry Pi Requirements

The Raspberry Pi does all the heavy lifting of camera access, image encoding, and streaming.

```bash
# Install with: sudo apt install $(cat streaming_scripts/pi/pi_requirements.txt | grep -v '^#' | tr '\n' ' ')

ffmpeg                   # Video/audio processing
python3-pip              # Python package manager
python3-opencv           # Computer vision library
python3-numpy            # Numerical computing
python3-picamera2        # Camera interface
gstreamer1.0-tools       # Multimedia framework
gstreamer1.0-plugins-*   # Various codec plugins
```

#### PC Requirements

For receiving streams on your PC, you only need GStreamer.

```bash
# Install with: sudo apt install $(cat streaming_scripts/pc/pc_requirements.txt | grep -v '^#' | tr '\n' ' ')

gstreamer1.0-tools        # gst-launch-1.0 command
gstreamer1.0-plugins-base # Core plugins (udpsrc, videoconvert, etc.)
gstreamer1.0-plugins-good # RTP plugins (rtph264depay, rtpopusdepay)
gstreamer1.0-plugins-bad  # Codec plugins (h264parse, opusdec)
```

## 👷 Set Up Instructions

### Raspberry Pi Setup

#### 1. Clone the Repository

```bash
git clone https://github.com/ez-turtlebot3/rpi-av-stream-scripts.git
cd rpi-av-stream-scripts
```

#### 2. Install Dependencies

```bash
sudo apt update
sudo apt install $(cat streaming_scripts/pi/pi_requirements.txt | grep -v '^#' | tr '\n' ' ')
```

#### 3. Configure Environment Variables

```bash
# Add export statements to bashrc
cat streaming_scripts/pi/bashrc_exports.pi.example >> ~/.bashrc
nano ~/.bashrc
```

Now scroll to the bottom of the `~/.bashrc` and adjust these values suit your hardware, software environment, and streaming preferences. Most importantly, make sure the `REMOTE_PC_IP` address matches the IP address of the PC you want to stream to. Save and exit, then source the edited file:

```bash
# Reload bashrc
source ~/.bashrc
```

### PC Setup

#### 1. Clone the Repository

```bash
git clone https://github.com/ez-turtlebot3/rpi-av-stream-scripts.git
cd rpi-av-stream-scripts
```

#### 2. Install GStreamer Dependencies

```bash
sudo apt update
sudo apt install $(cat streaming_scripts/pc/pc_requirements.txt | grep -v '^#' | tr '\n' ' ')
```

#### 3. Configure Environment Variables

```bash
# Add export statements to bashrc
cat streaming_scripts/pc/bashrc_exports.pc.example >> ~/.bashrc

# Most likely you will not have to change these export values

# Reload bashrc
source ~/.bashrc
```

### 4. Test Stream

```bash
# On Raspberry Pi
cd streaming_scripts/pi
./stream_video_to_pc.sh

# On PC
cd streaming_scripts/pc
./open_video_stream.sh
```

## 🚀 Example Uses

In all of these examples, start from `streaming_scripts/pi` on the pi and `streaming_scripts/pc` on the PC.

```bash
# On the pi
cd streaming_scripts/pi

# On the PC
cd streaming_scripts/pc
```

### Local Network Streaming

| Stream Type | Pi Command | PC Command |
|---------|---------------|-------------|
| Audio| ./stream_audio_to_pc.sh | ./open_audio_stream.sh |
| Video | ./stream_video_to_pc.sh | ./open_video_stream.sh |
| Video w/ Object Detection | python3 stream_object_detection_video_to_pc.py | ./open_video_stream.sh |

### Cloud Streaming

### YouTube Live Streaming with Object Detection

1. **Setup YouTube Channel:**
   - Create a YouTube channel and get approved for live streaming.
     - The first time you use a channel to go live YouTube starts a 24 hour approval process.
   - Open [YouTube Studio](https://studio.youtube.com)
   - Go live
     - When given the option of how you want to go live, select streaming software
   - Copy the stream key

2. **Configure Stream Key:**
   - On the Raspberry Pi, open the `~/.bashrc`
   ```bash
   nano ~/.bashrc
   ```
    - Edit this line:
   ```
   export YT_STREAM_KEY="your-stream-key-here"
   ```
    - Save and exit, then source the edited file.
   ```
   source ~/.bashrc
   ```

3. **Start Streaming from the Pi:**
   ```bash
   python3 stream_object_detection_video_to_YT.py
   ```

4. **Enjoy the show**
    - YouTube should show the Raspberry Pi camera feed with object detection overlays after a few seconds

### AWS Kinesis Video Streaming
The real leg work for streaming to Kinesis happens on the AWS side, which requires following the [Amazon Kinesis Developer Guide for Raspberry Pi](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/producersdk-cpp-rpi.html). Once you've finished with that guide, you probably won't need this script! Here it is anyway 😁
1. Edit the `AWS credentials` section of your `~/.bashrc` to match your real AWS credentials.
2. Run this script:
```
./stream_video_to_AWS
```

## 🌐 Streaming Options

| Feature | Local Network | AWS Kinesis | YouTube Live |
|---------|---------------|-------------|--------------|
| **Audio Streaming** | ✅ | ❌ | ❌ |
| **Video Streaming** | ✅ | ✅ | ✅ |
| **Object Detection** | ✅ | ❌ | ✅ |
| **Multi-Destination** | ✅ | ✅ | ✅ |
| **Setup Complexity** | 🟢 Easy | 🔴 Complex | 🟡 Medium |

## 🤝 Contributing

We welcome contributions! Please feel free to:

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🔄 Open a Pull Request

### Development Setup

This project uses pre-commit hooks to maintain code quality and **prevent secrets from being committed**. To set up the development environment:

```bash
# Install pre-commit
pip install pre-commit

# Install the pre-commit hooks
pre-commit install

# Run all hooks on all files (optional)
pre-commit run --all-files
```

The pre-commit hooks will automatically:
- **🔒 Prevent secrets from being committed** - Gitleaks scans for AWS keys, YouTube stream keys, and other sensitive data
- **Format Python code** with Black
- **Lint Python code** with Ruff
- **Format shell scripts** with shfmt
- **Check shell scripts** with ShellCheck
- **Remove trailing whitespace** and fix line endings
- **Check for large files** and security issues

> **⚠️ Security First:** Always use pre-commit hooks when working with this project. They prevent accidental commits of AWS credentials, YouTube stream keys, and other sensitive information that could expose your accounts.

## 📚 Related Projects

This repository is part of the **[ez-turtlebot3](https://github.com/ez-turtlebot3/)** project. In addition to adding these A/V streaming capabilities to a TurtleBot3, the project enables connecting analog sensors to the TurtleBot3 OpenCR board, then processing and broadcasting that analog data in ROS 2.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ for the Raspberry Pi community**

[![GitHub stars](https://img.shields.io/github/stars/ez-turtlebot3/rpi-av-stream-scripts?style=social)](https://github.com/your-username/rpi-av-stream-scripts)
[![GitHub forks](https://img.shields.io/github/forks/ez-turtlebot3/rpi-av-stream-scripts?style=social)](https://github.com/your-username/rpi-av-stream-scripts)

</div>
