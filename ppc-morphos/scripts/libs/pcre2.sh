#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install pcre2 ${CCEND}";
	curl -fsSL "https://github.com/walkero-gr/morphos-libs/raw/refs/heads/main/pcre2/pcre2-10.44.lha" -o /tmp/pcre2.lha && \
		lha -xfq2 pcre2.lha && \
		cp -r ./SDK/* /gg/ && \
		rm -rf /tmp/*;