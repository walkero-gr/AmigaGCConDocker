#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libiconv${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libiconv.lha" -o /tmp/libiconv.lha && \
		lha -xfq2 libiconv.lha && \
		cp -r ./libiconv-1.11/include/iconv.h \
			./libiconv-1.11/libcharset/include/libcharset.h \
			${SDK_PATH}/local/newlib/include/ && \
		cp -r ./libiconv-1.11/lib/libiconv* \
			${SDK_PATH}/local/newlib/lib/ && \
		cp -r ./libiconv-1.11/libcharset/lib/.libs/libcharset* \
			./libiconv-1.11/libcharset/lib/libcharset.la \
			${SDK_PATH}/local/newlib/lib/ && \
		rm -rf /tmp/*;
		\
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libiconv/libiconv-1.17.lha" -o /tmp/libiconv.lha && \
		lha -xfq2 libiconv.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;