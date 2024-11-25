#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install librtmp ${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/misc/librtmp.lha" -o /tmp/librtmp.lha && \
		lha -xfq2 librtmp.lha && \
		cp -r ./SDK/Local/* ${SDK_PATH}/local/ && \
		mv ./Docs ${SDK_PATH}/local/Documentation/librtmp && \
		rm -rf /tmp/*;