#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libregex ${CCEND}";
	curl -fsSL "https://aminet.net/dev/lib/libregex-4.4.3.lha" -o libregex.lha && \
		lha -xfq2 libregex.lha && \
		cp -r ./libregex/clib2/libregex.a ${SDK_PATH}/local/clib2/lib/ && \
		cp -r ./libregex/newlib/libregex.a ${SDK_PATH}/local/newlib/lib/ && \
		cp -r ./libregex/regex.h ${SDK_PATH}/local/common/include/ && \
		mkdir ${SDK_PATH}/local/Documentation/libregex && \
		cp ./libregex/COPYRIGHT ./libregex/README  ./libregex/README.amiga \
			./libregex/regex.3 ./libregex/regex.7 ./libregex/WHATSNEW \
			${SDK_PATH}/local/Documentation/libregex/ && \
		rm -rf /tmp/*;