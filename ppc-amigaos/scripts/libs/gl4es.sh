#!/usr/bin/bash
#
set -e

# https://github.com/kas1e/GL4ES-SDK/releases
echo -e "${CCPINK}${CCBOLD}\n---> Install GL4ES SDK ${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/graphics/gl4es_sdk.lha" -o /tmp/gl4es_sdk.lha && \
		lha -xfq2 gl4es_sdk.lha && \
		mkdir -p ${SDK_PATH}/local/common/include/GL4ES ${SDK_PATH}/local/newlib/lib/GL4ES && \
		cp -r ./SDK/local/newlib/lib/* ${SDK_PATH}/local/newlib/lib/GL4ES/ && \
		mv ./SDK/local/common/include/* ${SDK_PATH}/local/common/include/GL4ES/ && \
		mv ./SDK/Documentation/GL4ES ${SDK_PATH}/local/Documentation/ && \
		mv ./SDK/Examples/GL4ES ${SDK_PATH}/Examples && \
		rm -rf /tmp/*;
