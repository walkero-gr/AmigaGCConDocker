#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libft2${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/graphics/libft2-bin.lha" -o /tmp/libft2.lha && \
		lha -xfq2 libft2.lha && \
		cp -r ./SDK/Local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;