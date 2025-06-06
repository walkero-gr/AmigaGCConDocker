#!/usr/bin/bash

echo -e "${CCPINK}${CCBOLD}\n---> Install required tools ${CCEND}"
PACKAGES="\
	autoconf \
	automake \
	autopoint \
	bison \
	build-essential \
	ccache \
	cmake \
	cppcheck \
	curl \
	cvs \
	flawfinder \
	flex \
	gettext \
	git \
	gperf \
	libfl2 \
	libgmp-dev \
	libisl-dev \
	libmpc3 \
	libmpc-dev \
	libmpfr6 \
	libmpfr-dev \
	libtool \
	make \
	mandoc \
	mc \
	mercurial \
	meson \
	nano \
	pip \
	pkg-config \
	python3 \
	splint \
	ruby \
	subversion \
	sudo \
	texinfo \
	unzip \
	wget \
	zip"
	
apt-get update && apt-get -y dist-upgrade && \
	apt-get -y --no-install-recommends install $PACKAGES

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

mkdir -p /opt/code

ln -s /usr/bin/python3 /usr/bin/python

cd /tmp

# Install Lizard linter
echo -e "${CCPINK}${CCBOLD}\n---> Install Lizard linter${CCEND}"
	pip install lizard --break-system-packages

# Install FlexCat
echo -e "${CCPINK}${CCBOLD}\n---> Install FlexCat${CCEND}"
	curl -fsSL "https://github.com/adtools/flexcat/releases/download/2.18/FlexCat-2.18.lha" -o /tmp/FlexCat.lha && \
		lha -xfq2 FlexCat.lha && \
		cp ./FlexCat/Linux-i386/flexcat /usr/bin/ && \
		rm -rf /tmp/*;