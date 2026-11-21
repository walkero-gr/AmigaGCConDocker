#!/usr/bin/bash
#
# set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install latest MiniGL${CCEND}";
	curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://os4depot.net/share/driver/graphics/minigl.lha" -o /tmp/minigl.lha && \
		lha -xfq2 minigl.lha && \
		mkdir -p ${SDK_PATH}/local/common/include/MiniGL ${SDK_PATH}/local/Documentation/minigl \
      ${SDK_PATH}/local/newlib/lib/MiniGL ${SDK_PATH}/local/clib2/lib/MiniGL && \
		mv ./MiniGL/SDK/local/common/include/GL ${SDK_PATH}/local/common/include/MiniGL/ && \
		cp -r ./MiniGL/SDK/local/common/include/* ${SDK_PATH}/local/common/include/ && \
		cp -r ./MiniGL/SDK/local/newlib/lib/* ${SDK_PATH}/local/newlib/lib/MiniGL/ && \
		cp -r ./MiniGL/SDK/local/clib2/lib/* ${SDK_PATH}/local/clib2/lib/MiniGL/ && \
		mv ./MiniGL/License.txt ${SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/README ${SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/demos ${SDK_PATH}/Examples/minigl && \
		rm -rf /tmp/*;
