#!/usr/bin/bash

# Update nodejs repository
echo -e "${CCPINK}${CCBOLD}\n---> Add nodejs v24 repository ${CCEND}"
	cd /tmp && \
		curl --retry 5 --retry-delay 2 --retry-connrefused -sL https://deb.nodesource.com/setup_24.x -o nodesource_setup.sh && \
		chmod +x nodesource_setup.sh && \
		./nodesource_setup.sh && \
		rm -f nodesource_setup.sh

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
	libpcre2-dev \
	libtool \
	luarocks \
	make \
	mandoc \
	mc \
	mercurial \
	meson \
	nano \
	nodejs \
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

# Install RADRunner by Colin (hitman-codehq) Ward
# https://github.com/hitman-codehq/RADRunner
echo -e "${CCPINK}${CCBOLD}\n---> Install RADRunner ${CCEND}"
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL https://github.com/hitman-codehq/RADRunner/releases/download/latest_linux/RADRunner  -o /usr/bin/RADRunner
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL https://github.com/hitman-codehq/RADRunner/releases/download/latest_linux/RADRunner.debug  -o /usr/bin/RADRunner.debug
	chmod +x /usr/bin/RADRunner*

# Install Lizard linter
echo -e "${CCPINK}${CCBOLD}\n---> Install Lizard linter${CCEND}"
	pip install lizard --break-system-packages

# Install FlexCat
echo -e "${CCPINK}${CCBOLD}\n---> Install FlexCat${CCEND}"
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/adtools/flexcat/releases/download/2.18/FlexCat-2.18.lha" -o /tmp/FlexCat.lha && \
		lha -xfq2 FlexCat.lha && \
		cp ./FlexCat/Linux-i386/flexcat /usr/bin/ && \
		rm -rf /tmp/*;
