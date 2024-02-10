#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsmpeg2${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/graphics/libsmpeg2.lha" -o /tmp/libsmpeg2.lha && \
		lha -xfq2 libsmpeg2.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;