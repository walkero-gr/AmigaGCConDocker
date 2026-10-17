#!/usr/bin/bash
#
set -e

# https://github.com/salass00/pixman_lib/releases
echo -e "${CCPINK}${CCBOLD}\n---> Install pixman ${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://os4depot.net/share/library/graphics/pixman_lib.lha" -o pixman.lha && \
		lha -xfq2 pixman.lha && \
		cp -r ./pixman_lib-53.5/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
