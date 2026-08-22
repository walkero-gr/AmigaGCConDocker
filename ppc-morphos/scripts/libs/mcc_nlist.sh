#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install MCC_NList ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://aminet.net/dev/mui/MCC_NList-0.128.lha" -o /tmp/MCC_NList.lha && \
		lha -xfq2 /tmp/MCC_NList.lha && \
		cp -r ./MCC_NList/Developer/C/include/mui/* /gg/os-include/mui/ && \
		rm -rf /tmp/*;