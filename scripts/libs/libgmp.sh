#!/usr/bin/bash
# 

echo "---> Install libgmp";
	curl -fsSL "http://os4depot.net/share/development/library/math/libgmp.lha" -o /tmp/libgmp.lha && \
		lha -xfq2 libgmp.lha && \
		cp -r ./libgmp/SDK/Local/* ${OS4_SDK_PATH}/local/ && \
		rm -rf /tmp/*;