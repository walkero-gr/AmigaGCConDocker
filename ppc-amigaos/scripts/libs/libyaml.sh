#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libyaml${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libyaml/libyaml-0.2.5.lha" -o /tmp/libyaml.lha && \
		lha -xfq2 libyaml.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;