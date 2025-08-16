#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install pcre2${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/pcre2/pcre2-10.45.lha" -o /tmp/pcre2.lha && \
		lha -xfq2 pcre2.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;