## MILO - ARTIFICIAL INTELIGENCE DOG ROBOT
#############################
# Version 1.0.0

FROM raspbian/stretch
LABEL maintainer="https://github.com/vitorcalvi"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y wget nano git 

# Version 1.0.1
## SERVER OPENSSH

#RUN apt-get install -y openssh-server
#RUN mkdir /var/run/sshd
#RUN echo 'root:1' | chpasswd
#RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]


# Version 1.1.0
################
## INSTALL OPENCV
## Source: https://gist.github.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60

RUN wget https://gist.githubusercontent.com/vitorcalvi/5482f1a3006f42d4f9a336bcfc557bf0/raw/39600faf4477852c99220b2ddaf991da881d89f5/build-opencv.sh && \
wget https://gist.githubusercontent.com/vitorcalvi/5482f1a3006f42d4f9a336bcfc557bf0/raw/39600faf4477852c99220b2ddaf991da881d89f5/download-opencv.sh && \
wget https://gist.githubusercontent.com/vitorcalvi/5482f1a3006f42d4f9a336bcfc557bf0/raw/39600faf4477852c99220b2ddaf991da881d89f5/install-deps.sh
RUN chmod +x *.sh && ./download-opencv.sh && ./install-deps.sh && ./build-opencv.sh &&  cd ~/opencv/opencv-4.1.2/build && make install


# Version 1.1.1
###############
## INSTALL PYTHON 3.8.6 because TF doesnt work later than thins
WORKDIR /home
RUN sudo apt-get update -y
RUN sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev \
			 libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev \ 
			 liblzma-dev zlib1g-dev libffi-dev -y

RUN  wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tar.xz
RUN tar xf Python-3.8.6.tar.xz
WORKDIR Python-3.8.6
RUN  ./configure
RUN  make -j 4
RUN  sudo make install

RUN sudo rm -rf Python-3.8.6 && \
	sudo apt-get --purge remove build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev \ 
	libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y && \
	sudo apt-get autoremove -y && sudo apt-get clean


# Version 1.2.0
###############
## WAVEGO

RUN echo '' > /boot/cmdline.txt
ADD WAVEGO-DOF /tmp/WAVEGO-DOF
RUN python3 /tmp/WAVEGO-DOF/RPi/setup_docker.py
#ENTRYPOINT python3 /tmp/WAVEGO/RPi/webServer.py

## VERSION 1.3.0
##################
## PICO TTS

RUN sudo apt-get update && sudo apt-get install -y alsa-utils mplayer 
RUN wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico0_1.0+git20130326-9_armhf.deb \
	 && wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico-utils_1.0+git20130326-9_armhf.deb \
	 && sudo apt-get install -y -f ./libttspico0_1.0+git20130326-9_armhf.deb ./libttspico-utils_1.0+git20130326-9_armhf.deb

RUN sudo sed -i 's/defaults.pcm.card 0/defaults.pcm.card 1/g' /usr/share/alsa/alsa.conf && \
	 sed -i 's/defaults.ctl.card 0/defaults.ctl.card 1/g' /usr/share/alsa/alsa.conf




## VERSION 1.4.0
################
## TENSORFLOW FAT

#RUN sudo apt install -y python3-scipy python3-pyaudio libatlas3-base
#RUN wget http://192.168.1.50:9000/LEGACY/tensorflow-compilations/armv7l/tensorflow-2.4.0-cp35-none-linux_armv7l.whl
#RUN wget https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-2.1.0-cp35-none-linux_armv7l.whl
#RUN pip3 install tensorflow-*.whl
#RUN rm *.whl

#RUN wget https://github.com/Qengineering/Tensorflow-Raspberry-Pi/raw/master/tensorflow-2.1.0-cp37-cp37m-linux_armv7l.whl
#RUN  sudo -H pip3 install tensorflow-2.1.0-cp37-cp37m-linux_armv7l.whl
#RUN python -c 'import tensorflow as tf; print(tf.__version__)'  # for Python 2
RUN pip3 install tensorflow
RUN python3 -c 'import tensorflow as tf; print(tf.__version__)'  # for Python 3

# VERSION 1.4.1
###############
## TENSORFLOW LITE

