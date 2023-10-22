#!/usr/bin/bash
# 

echo "---> Install libopenssl";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libopenssl.lha" -o /tmp/libopenssl.lha && \
		lha -xfq2 libopenssl.lha && \
		cp -r ./libOpenSSL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		rm -rf /tmp/*;