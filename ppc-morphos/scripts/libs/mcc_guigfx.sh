#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install MCC-Guigfx ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://www.morphos-storage.net/dl.php?id=1901738" -o /tmp/MCC-Guigfx.lha && \
		lha -xfq2 /tmp/MCC-Guigfx.lha && \
		cp -r ./MCC-Guigfx/Developer/C/Include/MUI/* /gg/os-include/mui/ && \
		rm -rf /tmp/*;