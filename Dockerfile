## RASPBIAN BASE DOCKER IMAGE
#############################
# Version 1.0.0

FROM raspbian/stretch
LABEL maintainer="vitorcalvi"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN sudo apt-get install -y -q

RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget nano git -y


## SERVER OPENSSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]



RUN apt-get install python3 python3-pip -y 
ADD  WAVEGO WAVEGO
WORKDIR WAVEGO

RUN echo '' > /boot/cmdline.txt
RUN apt-get update 
RUN apt-get install -y python-dev python3-pip libfreetype6-dev libjpeg-dev \
build-essential i2c-tools python3-smbus libhdf5-dev libhdf5-serial-dev libatlas-base-dev \ 
libjasper-dev util-linux procps hostapd iproute2 iw haveged dnsmasq

RUN  apt-get install python-serial -y
RUN pip3 install --upgrade pip
#RUN  apt-get install python3-numpy -y
RUN pip3 install opencv-contrib-python
RUN apt-get install python3-flask -y


RUN pip3 install pyserial
RUN pip3 install flask
RUN pip3 install flask_cors
RUN pip3 install websockets

RUN pip3 install opencv-contrib-python
RUN apt-get -y install libhdf5-dev libhdf5-serial-dev libatlas-base-dev libjasper-dev
RUN pip3 install imutils zmq pybase64 psutil
RUN apt-get install -y util-linux procps hostapd iproute2 iw haveged dnsmasq



#RUN python3 RPi/setup.py

RUN python3 RPi/setup.py
WORKDIR /tmp
#RUN wget http://192.168.1.50:9000/12DOF/WAVEGO/RPi/webServer.py
#RUN apt-get install -y libharfbuzz0b libopenexr22 libavcodec-extra57 libtiff5 libwebp-dev
#ENTRYPOINT ['python3 /tmp/webServer.py']

##################
# INSTALL OPENCV #
##################

## https://github.com/opencv/opencv/releases
#ENV OPENCV_VERSION=4.5.4

RUN wget https://gist.githubusercontent.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60/raw/d3d8e2f2b619ff9d266d4614a27962870382ed2e/build-opencv.sh
RUN wget https://gist.githubusercontent.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60/raw/d3d8e2f2b619ff9d266d4614a27962870382ed2e/download-opencv.sh
RUN wget https://gist.githubusercontent.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60/raw/d3d8e2f2b619ff9d266d4614a27962870382ed2e/install-deps.sh

RUN chmod +x *.sh && ./download-opencv.sh && ./install-deps.sh && ./build-opencv.sh &&  cd ~/opencv/opencv-4.1.2/build && make install

ADD WAVEGO /tmp/WAVEGO
RUN python3 /tmp/WAVEGO/RPi/setup.py

#RUN git clone https://github.com/waveshare/WAVEGO
WORKDIR /tmp/WAVEGO/RPi
#ENTRYPOINT python3 /tmp/WAVEGO/RPi/webServer.py
