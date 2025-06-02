#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install source-highlight ${CCEND}";
	curl -fsSL "https://kas1e.mikendezign.com/aos4/source-highlight_3.1.9.zip" -o source-highlight.zip && \
		unzip -qq source-highlight.zip && \
		cp -r ./source-highlight/include/* ${SDK_PATH}/local/clib4/include/ && \
		cp -r ./source-highlight/lib/* ${SDK_PATH}/local/clib4/lib/ && \
		rm -rf /tmp/*;