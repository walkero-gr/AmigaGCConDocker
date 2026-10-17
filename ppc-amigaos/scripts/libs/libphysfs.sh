#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libphysfs ${CCEND}";
	if [ -f /opt/amigalabs-libs-ports/libphysfs/libphysfs-3.3.0.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}libphysfs-3.3.0.lha found locally. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/libphysfs/libphysfs-3.3.0.lha /tmp/libphysfs.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}libphysfs-3.3.0.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/libphysfs/libphysfs-3.3.0.lha" -o /tmp/libphysfs.lha
	fi
		lha -xfq2 /tmp/libphysfs.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
