#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libXMP ${CCEND}";
	curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://sdk.os4depot.net/files/libXMP.lha" -o /tmp/libXMP.lha && \
		lha -xfq2 libXMP.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
