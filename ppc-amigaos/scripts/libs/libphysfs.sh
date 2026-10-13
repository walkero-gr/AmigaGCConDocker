#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libphysfs ${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/libphysfs/libphysfs-3.3.0.lha" -o /tmp/libphysfs.lha && \
		lha -xfq2 /tmp/libphysfs.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
