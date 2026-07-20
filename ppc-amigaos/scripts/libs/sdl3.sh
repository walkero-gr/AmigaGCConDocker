#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install SDL3 SDK${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://sdk.os4depot.net/files/libSDL3.lha" -o /tmp/SDL3.lha && \
		lha -xfq2 SDL3.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		mkdir -p ${SDK_PATH}/local/Documentation/SDL3 && \
		cp ./Docs/* ${SDK_PATH}/local/Documentation/SDL3/ && \
		rm -rf /tmp/*;


		# cp -r ./SDL3/SDK/local/* ${SDK_PATH}/local/ && \
		# mkdir -p ${SDK_PATH}/local/Documentation/SDL3 && \
		# mv ./SDL3/LICENSE.txt ${SDK_PATH}/local/Documentation/SDL3/ && \
		# mv ./SDL3/README.md ${SDK_PATH}/local/Documentation/SDL3/ && \
		# mv ./SDL3/README-amigaos4.md ${SDK_PATH}/local/Documentation/SDL3/ && \
		# mv ./SDL3/WhatsNew.txt ${SDK_PATH}/local/Documentation/SDL3/ && \
		# rm -rf /tmp/*;
