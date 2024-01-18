#!/usr/bin/bash
# 

echo "---> Install mpfr";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/mpfr/mpfr-4.2.1.lha" -o /tmp/mpfr.lha && \
		lha -xfq2 mpfr.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;