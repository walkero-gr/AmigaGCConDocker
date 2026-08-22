#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install openal ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/audio/openal-soft.lha" -o /tmp/openal.lha && \
		lha -xfq2 /tmp/openal.lha && \
		cp -r ./openal-soft-1.18.2/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
