#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libpng16 ${CCEND}";
	curl -fsSL "https://github.com/salass00/png16_lib/releases/download/V53.3/png16_lib-53.3.lha" -o libpng16.lha && \
		lha -xfq2 libpng16.lha && \
		cp -r ./png16_lib/SDK/local/* ${SDK_PATH}/local/ && \
		ln -s ${SDK_PATH}/local/newlib/lib/libpng16.a \
			${SDK_PATH}/local/newlib/lib/libpng.a && \
		ln -s ${SDK_PATH}/local/newlib/lib/pkgconfig/libpng16.pc \
			${SDK_PATH}/local/newlib/lib/pkgconfig/libpng.pc && \
		rm -rf /tmp/*;