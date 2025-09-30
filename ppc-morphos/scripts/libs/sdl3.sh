#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install SDL3 SDK ${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=2403006" -o /tmp/SDL3.lha && \
		lha -xfq2 SDL3.lha && \
		cp -r ./SDL3-3.2.18/SDK/* /gg/ && \
		rm -rf /tmp/*;