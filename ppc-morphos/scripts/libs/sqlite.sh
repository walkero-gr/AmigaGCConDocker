#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install sqlite ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://www.morphos-storage.net/dl.php?id=2467712" -o /tmp/sqlite.lha && \
		lha -xfq2 /tmp/sqlite.lha && \
		cp -r ./sqlite-3.34.0/build-ppc-morphos/include/* /gg/include/ && \
		cp -r ./sqlite-3.34.0/build-ppc-morphos/lib/* /gg/lib/ && \
		rm -rf /tmp/*;