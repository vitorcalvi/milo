#!/usr/bin/env bash
set -ex

 apt-get purge -y libreoffice*
 apt-get clean
 apt-get update
 apt-get upgrade -y
 apt-get dist-upgrade -y
 apt-get autoremove -y
# For some reason I couldn't install libgtk2.0-dev or libgtk-3-dev without running the 
# following line
# See https://www.raspberrypi.org/forums/viewtopic.php?p=1254646#p1254665 for issue and resolution
 apt-get install -y devscripts debhelper cmake libldap2-dev libgtkmm-3.0-dev libarchive-dev \
                        libcurl4-openssl-dev intltool
 apt-get install -y build-essential cmake pkg-config libjpeg-dev libtiff5-dev libjasper-dev \
                        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                        libxvidcore-dev libx264-dev libgtk2.0-dev libgtk-3-dev \
                        libatlas-base-dev libblas-dev libeigen{2,3}-dev liblapack-dev \
                        gfortran \
                        python2.7-dev python3-dev python-pip python3-pip python python3
apt install curl -y
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
 python2 get-pip.py
 pip3 install -U pip
 #pip2 install numpy
 #pip3 install numpy