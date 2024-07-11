#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libmikmod${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/audio/libmikmod.lha" -o /tmp/libmikmod.lha && \
		lha -xfq2 libmikmod.lha && \
		cp -r ./libmikmod-3.3.11.1/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir -p ${SDK_PATH}/local/examples/mikmod && \
		cp -r ./libmikmod-3.3.11.1/drivers \
			./libmikmod-3.3.11.1/examples \
			${SDK_PATH}/local/examples/mikmod && \
		rm -rf /tmp/*;