#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libopus${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/audio/libopus.lha" -o /tmp/libopus.lha && \
		lha -xfq2 libopus.lha && \
		cp -r ./opus-1.6.1/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install libopusfile${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/audio/libopusfile.lha" -o /tmp/libopusfile.lha && \
		lha -xfq2 libopusfile.lha && \
		cp -r ./opusfile-0.12/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install libopusenc${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/audio/libopusenc.lha" -o /tmp/libopusenc.lha && \
		lha -xfq2 libopusenc.lha && \
		cp -r ./libopusenc-0.3/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
