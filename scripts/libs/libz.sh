#!/usr/bin/bash
# 

echo "---> Install libz";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libz.lha" -o /tmp/libz.lha && \
		lha -xfq2 libz.lha && \
		cp -r ./Zlib/SDK/Local/* ${OS4_SDK_PATH}/local/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/libz && \
		mv ./Zlib/README ${OS4_SDK_PATH}/local/Documentation/libz/ && \
		rm -rf /tmp/*;