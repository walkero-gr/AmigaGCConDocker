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
	libpcre2-dev \
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
	qt6-base-dev \
	qt6-tools-dev \
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

# Install qt6 SDK
echo -e "${CCPINK}${CCBOLD}\n---> Install qt6 SDK ${CCEND}";
	curl -fsSL "https://github.com/elfpipe/amiga-qt6/releases/download/v6.2.0public-static2/qt6-amigaos-sdk.tar.gz" -o /tmp/qt6.tar.gz && \
		tar -xzf /tmp/qt6.tar.gz --directory /
	# replace the path "/usr/local/Qt-6.2.0" with "/usr/lib/qt6" on every file in the qt6-amiga directory
	find /qt6-amiga -type f -exec sed -i 's|/usr/local/Qt-6.2.0|/usr/lib/qt6|g' {} +
	
	rm -rf /tmp/*;