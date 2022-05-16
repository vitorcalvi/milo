## RASPBIAN BASE DOCKER IMAGE
#############################
# Version 1.0.0

FROM raspbian/stretch
LABEL maintainer="vitorcalvi"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
#RUN sudo apt-get install -y -q

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y wget nano git 


# Version 1.1.0
## INSTALL OPENCV
## Source: https://gist.github.com/willprice/abe456f5f74aa95d7e0bb81d5a710b60

RUN wget https://gist.githubusercontent.com/vitorcalvi/5482f1a3006f42d4f9a336bcfc557bf0/raw/39600faf4477852c99220b2ddaf991da881d89f5/build-opencv.sh && \
wget https://gist.githubusercontent.com/vitorcalvi/5482f1a3006f42d4f9a336bcfc557bf0/raw/39600faf4477852c99220b2ddaf991da881d89f5/download-opencv.sh && \
wget https://gist.githubusercontent.com/vitorcalvi/5482f1a3006f42d4f9a336bcfc557bf0/raw/39600faf4477852c99220b2ddaf991da881d89f5/install-deps.sh
RUN chmod +x *.sh && ./download-opencv.sh && ./install-deps.sh && ./build-opencv.sh &&  cd ~/opencv/opencv-4.1.2/build && make install


# INstall Python 3.9.4
WORKDIR /home
RUN sudo apt-get update -y
RUN sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev \
			 libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev \ 
			 liblzma-dev zlib1g-dev libffi-dev -y
RUN  wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tar.xz
RUN tar xf Python-3.9.4.tar.xz
WORKDIR Python-3.9.4
RUN  ./configure
RUN  make -j 4
RUN  sudo make install

WORKDIR /home
RUN sudo rm -rf Python-3.9.4
RUN rm Python-3.9.4.tar.xz
RUN sudo apt-get --purge remove build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev \ 
	libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
RUN sudo apt-get autoremove -y && sudo apt-get clean


RUN apt-get install -y \ 
	python3-dev python3-pip python3-smbus  \
	python3-serial python3-yaml python3-setuptools \
	libfreetype6-dev libjpeg-dev \
	build-essential i2c-tools \
	libhdf5-dev  \
	libhdf5-serial-dev \
	libatlas-base-dev libjasper-dev \ 
	util-linux procps hostapd iproute2 iw \
	haveged dnsmasq util-linux procps \ 
	hostapd iproute2 iw haveged dnsmasq \
	libopenexr-dev libqtgui4 libqt4-test \
	libopenblas-dev libblas-dev m4 \
        cmake cython \
        libatomic-ops-dev llvm \
        espeak libsndfile1 \
        libzstd1 libjbig0 \
        libwebpdemux2 libtiff5 \
        libwebp6 libatlas3-base



RUN pip3 install --upgrade pip
RUN pip3 install pyserial flask flask_cors  
RUN pip3 install websockets imutils zmq 
RUN pip3 install pybase64 psutil 

# Version 1.2.1
## WAVEGO
RUN echo '' > /boot/cmdline.txt

ADD WAVEGO /tmp/WAVEGO
RUN python3 /tmp/WAVEGO/RPi/setup.py
WORKDIR /tmp/WAVEGO/RPi

#ENTRYPOINT python3 /tmp/WAVEGO/RPi/webServer.py

## VERSION 1.3.0
##################

#RUN pip3 install deepspeech
#RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-cp37-cp37m-linux_armv7l.whl
#RUN pip3 install --upgrade setuptools pip

#RUN pip install 'https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-cp37-cp37m-linux_aarch64.whl'
#RUN pip3 install 'https://github.com/mozilla/DeepSpeech/releases/download/v0.9.2/deepspeech-0.9.2-cp37-cp37m-linux_armv7l.whl'
## Mozilla TXT-Speach
## docker run -it --cap-add=SYS_ADMIN --cap-add=NET_ADMIN --net=host ......
#RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-cp37-cp37m-linux_aarch64.whl
#RUN pip3 install --user deepspeech-0.9.3-cp37-cp37m-linux_aarch64.whl


## VERSION 1.3.1
#RUN git clone  https://github.com/mozilla/TTS.git
#RUN wget http://192.168.1.50:9000/LEGACY/TTS.tar.gz
#RUN tar xf TTS.tar.gz

#WORKDIR TTS
#RUN sudo apt-get install gcc-4.9 -y
#RUN sudo apt-get upgrade libstdc++6 -y
#RUN sudo apt-get install -y python3-numpy
#RUN sudo apt-get install libatlas-base-dev -y

## PICO TTS
#RUN apt-get update -y
#RUN wget https://launchpad.net/ubuntu/+archive/primary/+files/hardening-includes_2.8+nmu3ubuntu1_all.deb
#RUN dpkg -i hardening-includes_2.8+nmu3ubuntu1_all.deb
#RUN sudo apt-get install -y fakeroot debhelper automake autoconf libtool help2man libpopt-dev 
#RUN mkdir pico_build
#USER root
#WORKDIR pico_build
#RUN apt-get source libttspico-utils
#WORKDIR svox-1.0+git20110131
#RUN dpkg-buildpackage  -us -uc
#RUN sudo dpkg -i libttspico-data_1.0+git20110131-2_all.deb
#RUN sudo dpkg -i libttspico0_1.0+git20110131-2_armhf.deb
#RUN sudo dpkg -i libttspico-utils_1.0+git20110131-2_armhf.deb

#RUN pip3 install --trusted-host pypi.org --trusted-host piwheels.org torch
#RUN pip3 install tensorflow==2.3.1
#RUN pip3 install numpy==1.17.5
#RUN pip3 install scipy>=0.19.0
#RUN pip3 install numba==0.48
#RUN pip3 install librosa==0.7.2
#RUN pip3 install phonemizer>=2.2.0
#RUN pip3 install unidecode==0.4.20
#RUN pip3 install tensorboardX
#RUN pip3 install matplotlib
#RUN pip3 install Pillow
#RUN pip3 install tqdm
#RUN pip3 install inflect
#RUN pip3 install bokeh==1.4.0
#RUN pip3 install pysbd
#RUN pip3 install pyworld
#RUN pip3 install soundfile
#RUN pip3 install nose==1.3.7
#RUN pip3 install cardboardlint==1.3.0
#RUN pip3 install pylint==2.5.3
#RUN pip3 install gdown
#RUN pip3 install umap-learn
#RUN pip3 install cython
#RUN pip3 install pyyaml


#RUN pip3 install -e .


