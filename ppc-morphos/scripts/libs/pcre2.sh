#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install pcre2 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/walkero-gr/morphos-libs/raw/refs/heads/main/pcre2/pcre2-10.48.lha" -o /tmp/pcre2.lha && \
		lha -xfq2 pcre2.lha && \
		cp -r ./pcre2-10.48/SDK/* /gg/ && \
		rm -rf /tmp/*;
