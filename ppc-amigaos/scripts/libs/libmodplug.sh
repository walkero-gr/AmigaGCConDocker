#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libmodplug${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/audio/libmodplug.lha" -o /tmp/libmodplug.lha && \
		lha -xfq2 libmodplug.lha && \
		cp -r ./libmodplug-0.8.9.1/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir -p ${SDK_PATH}/local/examples/libmodplug && \
		cp -r ./libmodplug-0.8.9.1/modplugplay \
			${SDK_PATH}/local/examples/libmodplug && \
		rm -rf /tmp/*;