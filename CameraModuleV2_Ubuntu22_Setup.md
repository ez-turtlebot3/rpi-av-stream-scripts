The following procedure is how we configured the Camera Module v2 on a Raspberry Pi 4b running Ubuntu 22 LTS. If you're using ROS, you could also try following one of the two methods described on the [turtlebot3 raspberry pi camera setup page](https://emanual.robotis.com/docs/en/platform/turtlebot3/sbc_setup/#raspberry-pi-camera).

# Install debian package dependencies

```
sudo apt install clang meson ninja-build pkg-config libyaml-dev python3-yaml python3-ply python3-jinja2 openssl

sudo apt install libdw-dev libunwind-dev libudev-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libpython3-dev pybind11-dev libevent-dev libtiff-dev

sudo apt install cmake libboost-program-options-dev libdrm-dev libexif-dev ffmpeg libavcodec-extra libavcodec-dev libavdevice-dev

sudo apt install libcamera-dev libepoxy-dev libjpeg-dev libtiff5-dev libpng-dev python3 python3-dev libcamera-tools g++ python3-pip git libboost-dev libgnutls28-dev pybind11-dev liblttng-ust-dev

sudo apt install gstreamer1.0-*

sudo apt-get install gstreamer1.0-plugins-base
```

# Install libcamera

```
cd /usr/local/src

git clone https://github.com/raspberrypi/libcamera.git

cd libcamera

meson setup build --buildtype=release -Dpipelines=rpi/vc4,rpi/pisp -Dipas=rpi/vc4,rpi/pisp -Dv4l2=true -Dgstreamer=enabled -Dtest=false -Dlc-compliance=disabled -Dcam=disabled -Dqcam=disabled -Ddocumentation=disabled

ninja -C build

sudo ninja -C build install
```

# Install rpicam

```
cd /usr/local/src

git clone https://github.com/raspberrypi/rpicam-apps.git

cd rpicam-apps

meson setup build

ninja -C build

sudo ninja -C build install

sudo ldconfig
```

# Update the boot config:

`sudo nano /boot/firmware/config.txt`

Add the following lines at the end of the file, still under [all]

```
# Camera module configuration
dtoverlay=imx219
dtoverlay=vc4-kms-v3d,cma-512
```

Save the file and reboot the Raspberry Pi.

# Test the Camera:

    rpicam-hello --list-cameras

    rpicam-hello --camera 0
