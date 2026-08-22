#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install SDI ${CCEND}";
	git clone https://github.com/adtools/SDI.git && \
		cp -r ./SDI/SDI_* /gg/include/ && \
		rm -rf /tmp/*;