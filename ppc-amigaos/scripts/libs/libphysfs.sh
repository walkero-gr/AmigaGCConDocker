#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libphysfs ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/libphysfs/libphysfs-3.3.0.lha" -o /tmp/libphysfs.lha && \
		lha -xfq2 /tmp/libphysfs.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
