#!/usr/bin/bash
#
set -e

# https://github.com/kas1e/GL4ES-SDK/releases
echo -e "${CCPINK}${CCBOLD}\n---> Install mesa SDK ${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/graphics/mesa.lha" -o /tmp/mesa.lha && \
		lha -xfq2 mesa.lha && \
		mkdir -p ${SDK_PATH}/local/common/include/mesa ${SDK_PATH}/local/common/lib/mesa && \
		cp -r ./mesa/SDK/include/include_h/* ${SDK_PATH}/local/common/include/ && \
		cp -r ./mesa/SDK/local/common/include/* ${SDK_PATH}/local/common/include/mesa && \
		cp -r ./mesa/SDK/local/common/lib/* ${SDK_PATH}/local/common/lib/mesa && \
		rm -rf /tmp/*;
