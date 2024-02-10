#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libgmp${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/gmp/gmp-6.3.0.lha" -o /tmp/gmp.lha && \
		lha -xfq2 gmp.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;