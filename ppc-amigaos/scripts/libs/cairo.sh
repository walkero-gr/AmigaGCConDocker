#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install Cairo ${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libcairo/libcairo-1.14.10.lha" -o /tmp/libcairo.lha && \
		lha -xfq2 libcairo.lha && \
		\cp -R ./SDK/* ${SDK_PATH}/ && \
		rm -rf /tmp/*;
