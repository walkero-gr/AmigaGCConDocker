#!/usr/bin/bash

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
	mc \
	mercurial \
	meson \
	nano \
	pkg-config \
	python2.7 \
	python3 \
	splint \
	ruby \
	subversion \
	sudo \
	texinfo \
	wget"
	
apt-get update && apt-get -y dist-upgrade && \
	apt-get -y --no-install-recommends install $PACKAGES;

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

mkdir -p /opt/code
# rm -rf ${APPC}/ppc-amigaos/SDK && \
# 	ln -s /opt/sdk/ppc-amigaos/ ${APPC}/ppc-amigaos/SDK

cd /tmp

# Install FlexCat
echo "-> Install FlexCat";
	curl -fsSL "https://github.com/adtools/flexcat/releases/download/2.18/FlexCat-2.18.lha" -o /tmp/FlexCat.lha && \
		lha -xfq2 FlexCat.lha && \
		cp ./FlexCat/Linux-i386/flexcat /usr/bin/ && \
		rm -rf /tmp/*;