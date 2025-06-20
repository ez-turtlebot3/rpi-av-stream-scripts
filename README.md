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
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Usage Examples](#-usage-examples)
- [Streaming Options](#-streaming-options)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [Related Projects](#-related-projects)

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

> **⚠️ Compatibility Note:** The Raspberry Pi AI Camera is **not compatible** with Ubuntu 22.04. Use the Camera Module v2 instead.

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
ffmpeg                   # Video/audio processing
python3-pip              # Python package manager
python3-opencv           # Computer vision library
python3-numpy            # Numerical computing
python3-picamera2        # Camera interface
gstreamer1.0-tools       # Multimedia framework
gstreamer1.0-plugins-*   # Various codec plugins
```

#### PC Requirements
For receiving streams on your PC, you only need GStreamer:

```bash
# Essential GStreamer packages for video/audio streaming
gstreamer1.0-tools        # gst-launch-1.0 command
gstreamer1.0-plugins-base # Core plugins (udpsrc, videoconvert, etc.)
gstreamer1.0-plugins-good # RTP plugins (rtph264depay, rtpopusdepay)
gstreamer1.0-plugins-bad  # Codec plugins (h264parse, opusdec)
```

> **💡 Note:** The PC scripts use `gst-launch-1.0` to receive and play streams. These packages provide all the necessary plugins for RTP video/audio streaming.

## 👷 Set Up Instructions TODO: Separate PC and Pi

### 1. Clone the Repository

```bash
git clone https://github.com/ez-turtlebot3/rpi-av-stream-scripts.git
cd rpi-av-stream-scripts
```

### 2. Install Dependencies

```bash
sudo apt update
sudo apt install $(cat streaming_scripts/system_requirements.txt | grep -v '^#' | tr '\n' ' ')
```

### 3. Configure Environment Variables

Copy the export statements from `pc/bashrc_exports.pc.example` to your PC's `~/.bashrc`. You probably don't need to edit these.
```bash
# On PC
cd streamin
```


on your PC and pi/bashrc_exports.pi.example to your ~/.bashrc on your pi. Remember to source the new bashrc files after you edit them :)

```bash
# On Raspberry Pi
cp streaming_scripts/pi/bashrc_exports.pi.example ~/.bashrc_exports
echo "source ~/.bashrc_exports" >> ~/.bashrc

# On PC
cp streaming_scripts/pc/bashrc_exports.pc.example ~/.bashrc_exports
echo "source ~/.bashrc_exports" >> ~/.bashrc

# Reload configuration
source ~/.bashrc
```

### 4. Test stream

```bash
# Navigate to scripts directory
cd streaming_scripts/pi

# Stream video to PC
./stream_video_to_pc.sh
```

## 📁 Project Structure

```
rpi-av-stream-scripts/
├── 📂 streaming_scripts/
│   ├── 📂 pi/                    # Raspberry Pi scripts
│   │   ├── 🎵 stream_audio_to_pc.sh
│   │   ├── 📹 stream_video_to_pc.sh
│   │   ├── 🤖 stream_object_detection_video_to_pc.py
│   │   ├── ☁️ stream_video_to_AWS.sh
│   │   └── 📺 stream_object_detection_video_to_YT.py
│   └── 📂 pc/                    # PC receiver scripts
│       ├── 🎵 open_audio_stream.sh
│       └── 📹 open_video_stream.sh
├── 📋 system_requirements.txt
└── 📖 README.md
```

## 🎯 Usage Examples

### Basic Video Streaming

**On Raspberry Pi:**
```bash
cd streaming_scripts/pi
./stream_video_to_pc.sh
```

**On PC:**
```bash
cd streaming_scripts/pc
./open_video_stream.sh
```

### AI Object Detection Streaming

**On Raspberry Pi:**
```bash
cd streaming_scripts/pi
python3 stream_object_detection_video_to_pc.py
```

**On PC:**
```bash
cd streaming_scripts/pc
./open_video_stream.sh
```

### YouTube Live Streaming

1. **Setup YouTube Channel:**
   - Create/verify YouTube channel
   - Enable live streaming (first-time approval required)
   - Get stream key from [YouTube Studio](https://studio.youtube.com)

2. **Configure Stream Key:**
   ```bash
   # Add to ~/.bashrc
   export YT_STREAM_KEY="your-stream-key-here"
   source ~/.bashrc
   ```

3. **Start Streaming:**
   ```bash
   cd streaming_scripts/pi
   python3 stream_object_detection_video_to_YT.py
   ```

## 🌐 Streaming Options

| Feature | Local Network | AWS Kinesis | YouTube Live |
|---------|---------------|-------------|--------------|
| **Audio Streaming** | ✅ | ❌ | ❌ |
| **Video Streaming** | ✅ | ✅ | ✅ |
| **Object Detection** | ✅ | ❌ | ✅ |
| **Multi-Destination** | ✅ | ❌ | ✅ |
| **Setup Complexity** | 🟢 Easy | 🔴 Complex | 🟡 Medium |

### Local Network Streaming

- **Audio:** `stream_audio_to_pc.sh` → `open_audio_stream.sh`
- **Video:** `stream_video_to_pc.sh` → `open_video_stream.sh`
- **AI Video:** `stream_object_detection_video_to_pc.py` → `open_video_stream.sh`

### Cloud Streaming

- **AWS Kinesis:** Requires [AWS setup guide](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/producersdk-cpp-rpi.html)
- **YouTube Live:** Requires channel approval and stream key

## 🔧 Configuration

### Environment Variables

Key variables to configure in your `~/.bashrc`:

```bash
# Network configuration
export PC_IP="192.168.1.100"        # Your PC's IP address
export PI_IP="192.168.1.101"         # Your Pi's IP address
export STREAM_PORT="5000"            # Streaming port

# YouTube configuration
export YT_STREAM_KEY="your-key"      # YouTube stream key

# AWS configuration (if using Kinesis)
export AWS_REGION="us-east-1"        # AWS region
export AWS_ACCESS_KEY="your-key"     # AWS access key
```

### Camera Configuration

For Ubuntu 22.04 users, see our detailed setup guide:
📖 [Camera Module v2 Ubuntu 22.04 Setup Guide](CameraModuleV2_Ubuntu22_Setup.md)

## 🛠️ Troubleshooting

### Common Issues

**❌ Camera not detected:**
```bash
# Check camera module
vcgencmd get_camera

# Enable camera interface
sudo raspi-config
# Navigate to: Interface Options → Camera → Enable
```

**❌ Permission denied:**
```bash
# Make scripts executable
chmod +x streaming_scripts/pi/*.sh
chmod +x streaming_scripts/pc/*.sh
```

**❌ Network connection failed:**
```bash
# Check network connectivity
ping $PC_IP
ping $PI_IP

# Verify firewall settings
sudo ufw status
```

### Performance Optimization

- **Reduce latency:** Lower video resolution or bitrate
- **Improve quality:** Increase bitrate (may increase latency)
- **CPU usage:** Use hardware encoding when available

## 🤝 Contributing

We welcome contributions! Please feel free to:

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🔄 Open a Pull Request

### Development Setup

```bash
# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
python -m pytest tests/

# Check code style
flake8 streaming_scripts/
```

## 📚 Related Projects

This repository is part of the **[ez-turtlebot3](https://github.com/ez-turtlebot3/ez-turtlebot3)** project, which provides comprehensive robotics development tools and resources.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ for the Raspberry Pi community**

[![GitHub stars](https://img.shields.io/github/stars/ez-turtlebot3/rpi-av-stream-scripts?style=social)](https://github.com/your-username/rpi-av-stream-scripts)
[![GitHub forks](https://img.shields.io/github/forks/ez-turtlebot3/rpi-av-stream-scripts?style=social)](https://github.com/your-username/rpi-av-stream-scripts)

</div>
