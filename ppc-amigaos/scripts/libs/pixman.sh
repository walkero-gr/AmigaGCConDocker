#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install pixman ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/salass00/pixman_lib/releases/download/V53.5/pixman_lib-53.5.lha" -o pixman.lha && \
		lha -xfq2 pixman.lha && \
		cp -r ./pixman_lib-53.5/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
