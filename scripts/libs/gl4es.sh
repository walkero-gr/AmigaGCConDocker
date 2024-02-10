#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install GL4ES SDK${CCEND}";
	curl -fsSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.2/gl4es_sdk-1.2.lha" -o /tmp/gl4es_sdk.lha && \
		lha -xfq2 gl4es_sdk.lha && \
		cp -r ./SDK/local/newlib/* ${SDK_PATH}/local/newlib/ && \
		mv ./SDK/local/common/include/GL ${SDK_PATH}/local/common/include/GL4ES && \
		mv ./SDK/Documentation/GL4ES ${SDK_PATH}/local/Documentation/ && \
		mv ./SDK/Examples/GL4ES ${SDK_PATH}/Examples && \
		rm -rf /tmp/*;