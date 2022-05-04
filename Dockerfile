## RASPBIAN BASE DOCKER IMAGE
#############################
# Version 1.0.0

FROM raspbian/stretch
LABEL maintainer="vitorcalvi"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN sudo apt-get install -y -q

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget nano git python3 python3-pip 


# Version 1.1.0
## INSTALL OPENCV
## Source: https://gist.github.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60

RUN wget 'https://gist.githubusercontent.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60/raw/d3d8e2f2b619ff9d266d4614a27962870382ed2e/build-opencv.sh'
RUN wget https://gist.githubusercontent.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60/raw/d3d8e2f2b619ff9d266d4614a27962870382ed2e/download-opencv.sh
RUN wget https://gist.githubusercontent.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60/raw/d3d8e2f2b619ff9d266d4614a27962870382ed2e/install-deps.sh
RUN chmod +x *.sh && ./download-opencv.sh && ./install-deps.sh && ./build-opencv.sh &&  cd ~/opencv/opencv-4.1.2/build && make install

# Version 1.2.1
## WAVEGO

ADD WAVEGO WAVEGO
WORKDIR WAVEGO

RUN echo '' > /boot/cmdline.txt
RUN apt-get update 
RUN apt-get install -y python-dev python3-pip libfreetype6-dev libjpeg-dev \
	build-essential i2c-tools python3-smbus libhdf5-dev libhdf5-serial-dev \
	libatlas-base-dev libjasper-dev util-linux procps hostapd iproute2 iw \
	haveged dnsmasq util-linux procps hostapd iproute2 iw haveged dnsmasq \
	libopenexr-dev libqtgui4 libqt4-test python-serial

#RUN apt-get install python3-flask -y

RUN pip3 install --upgrade pip
RUN pip3 install opencv-contrib-python pyserial flask flask_cors websockets \
		 imutils zmq pybase64 psutil

RUN python3 RPi/setup.py
WORKDIR /tmp

ADD WAVEGO /tmp/WAVEGO
RUN python3 /tmp/WAVEGO/RPi/setup.py

WORKDIR /tmp/WAVEGO/RPi


#ENTRYPOINT python3 /tmp/WAVEGO/RPi/webServer.py

## VERSION 1.3.0
## ADD BLUETOOTH

# RUN apt install -y bluetooth pi-bluetooth bluez blueman

## VERSION 1.4.0
## Mozilla TXT-Speach
## docker run -it --cap-add=SYS_ADMIN --cap-add=NET_ADMIN --net=host ......

#RUN apt install -y git python3-venv libopenblas-dev \
#libblas-dev m4 cmake cython python3-dev python3-yaml \
#python3-setuptools libatomic-ops-dev llvm espeak \
#libsndfile1 libzstd1 libjbig0 \
#libwebpdemux2 libtiff5 libwebp6 libatlas3-base
#RUN pip3 install TTS
#RUN sudo apt-get install espeak -y

#RUN git clone  https://github.com/mozilla/TTS.git
#RUN cd TTS
#RUN git checkout 2e2221f
#RUN pip install numpy==1.16.1 matplotlib==3.2.1 bokeh==1.4.0 Flask pyyaml attrdict segments scipy tensorboard tensorboardX Pillow Unidecode>=0.4.20 tqdm soundfile phonemizer
