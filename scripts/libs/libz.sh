#!/usr/bin/bash
# 

echo "---> Install libz";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libz.lha" -o /tmp/libz.lha && \
		lha -xfq2 libz.lha && \
		cp -r ./Zlib/SDK/Local/* ${SDK_PATH}/local/ && \
		mkdir ${SDK_PATH}/local/Documentation/libz && \
		mv ./Zlib/README ${SDK_PATH}/local/Documentation/libz/ && \
		rm -rf /tmp/*;