#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libxml2 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://www.morphos-storage.net/dl.php?id=1532623" -o /tmp/libxml2.lha && \
		lha -xfq2 libxml2.lha && \
		cp -r ./libxml2/include/* /gg/include/ && \
		cp -r ./libxml2/lib/* /gg/lib/ && \
		rm -rf /tmp/*;