#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install latest MiniGL${CCEND}";
	curl -fsSL "http://os4depot.net/share/driver/graphics/minigl.lha" -o /tmp/minigl.lha && \
		lha -xfq2 minigl.lha && \
		cp -r ./MiniGL/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir ${SDK_PATH}/local/Documentation/minigl && \
		mv ./MiniGL/License.txt ${SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/README ${SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/demos ${SDK_PATH}/Examples/minigl && \
		rm -rf /tmp/*;