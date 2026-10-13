#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install openal ${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/libopenal/libopenal-1.18.2.lha" -o /tmp/openal.lha && \
		lha -xfq2 /tmp/openal.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
