#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libflac${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "http://os4depot.net/share/development/library/audio/libflac.lha" -o /tmp/libflac.lha && \
		lha -xfq2 libflac.lha && \
		cp -r ./flac-1.5.0/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;