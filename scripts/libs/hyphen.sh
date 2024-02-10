#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install hyphen library${CCEND}";
	curl -fsSL "https://git.walkero.gr/attachments/34d7bbc2-b8a2-46ad-b30c-8e5bb8e2fb45" -o /tmp/libhyphen.lha && \
		lha -xfq2 libhyphen.lha && \
		\cp ./release/* ${SDK_PATH}/ -R && \
		rm -rf /tmp/*;