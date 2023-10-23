#!/usr/bin/bash

apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	gpg;

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

OS3_SDK_PATH="/opt/sdk/m68k-amigaos"
mkdir -p $OS3_SDK_PATH

cd /tmp

# Install MUI 5.0 SDK
echo "-> Install MUI 5.0 SDK";
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os3.lha" -o /tmp/MUI-5.0.lha && \
	lha -xfq2 MUI-5.0.lha; \
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os3-contrib.lha" -o /tmp/MUI-5.0-contrib.lha && \
	lha -xfq2 MUI-5.0-contrib.lha; \
	mv ./SDK/MUI /opt/sdk/MUI_5.0; \
	rm -rf /tmp/*;

# Install AmigaOS 3 NDK
echo "-> Install AmigaOS 3 NDK";
	curl -fskSL "http://aminet.net/dev/misc/NDK3.2.lha" -o /tmp/NDK3.2.lha && \
		lha -xfq2 NDK3.2.lha && \
		mv ./FD /opt/sdk/m68k-amigaos/ && \
		mv ./Include_H /opt/sdk/m68k-amigaos/ && \
		mv ./Include_I /opt/sdk/m68k-amigaos/ && \
		mv ./SANA+RoadshowTCP-IP /opt/sdk/m68k-amigaos/ && \
		mv ./SFD /opt/sdk/m68k-amigaos/ && \
		mv ./lib /opt/sdk/m68k-amigaos/
	rm -rf /tmp/*;

	# 	cp -r $OS4_SDK_PATH/Examples/Locale/include/internal/* $OS4_SDK_PATH/Include/include_h/ && \
	# 	mv $OS4_SDK_PATH/Include/ $OS4_SDK_PATH/include/ && \
	# 	cp -r $OS4_SDK_PATH/Local/* $OS4_SDK_PATH/local/;

	
	# rm -rf $OS4_SDK_PATH/Local $OS4_SDK_PATH/C $OS4_SDK_PATH/Data $OS4_SDK_PATH/S \
	# 		$OS4_SDK_PATH/AmigaOS\ 4.1\ SDK.pdf.info \
	# 		$OS4_SDK_PATH/Documentation.info;
	# 
