#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install uchardet ${CCEND}";
	curl -fsSL "https://github.com/walkero-gr/morphos-libs/raw/main/uchardet/uchardet-v0.0.8.lha" -o /tmp/uchardet.lha && \
		lha -xfq2 uchardet.lha && \
		cp -r ./uchardet-v0.0.8/SDK/* /gg/ && \
		rm -rf /tmp/*;