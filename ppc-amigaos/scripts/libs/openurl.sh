#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install OpenURL library${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://aminet.net/comm/www/OpenURL-7.18.lha" -o /tmp/openurl.lha && \
		lha -xfq2 openurl.lha && \
		cp -r ./OpenURL/Developer/C/include/* ${SDK_PATH}/local/common/include/ && \
		mkdir -p ${SDK_PATH}/local/Documentation/OpenURL && \
		cp -r ./OpenURL/Developer/Autodocs/* ${SDK_PATH}/local/Documentation/OpenURL && \
		rm -rf /tmp/*;