#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libSDL3_mixer ${CCEND}";
	curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://sdk.os4depot.net/files/libSDL3_mixer.lha" -o /tmp/libSDL3_mixer.lha && \
		lha -xfq2 libSDL3_mixer.lha && \
		cp -r ./SDL3_mixer-3.2.4/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
