#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install jansson library${CCEND}";
	curl -fsSL "https://walkero.gr/betas/jansson_library_2.12.1_sdk.lha" -o /tmp/jansson.lha && \
		lha -xfq2 jansson.lha && \
		cp -r ./local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;