#!/usr/bin/bash
# 

echo "---> Install latest MiniGL";
	curl -fsSL "http://os4depot.net/share/driver/graphics/minigl.lha" -o /tmp/minigl.lha && \
		lha -xfq2 minigl.lha && \
		cp -r ./MiniGL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/minigl && \
		mv ./MiniGL/License.txt ${OS4_SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/README ${OS4_SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/demos ${OS4_SDK_PATH}/Examples/minigl && \
		rm -rf /tmp/*;