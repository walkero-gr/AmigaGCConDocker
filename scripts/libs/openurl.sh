#!/usr/bin/bash
# 

echo "---> Install codesets library";
	curl -fsSL "http://aminet.net/comm/www/OpenURL-7.18.lha" -o /tmp/openurl.lha && \
		lha -xfq2 openurl.lha && \
		cp -r ./OpenURL/Developer/C/include/* ${OS4_SDK_PATH}/local/common/include/ && \
		mkdir -p ${OS4_SDK_PATH}/local/Documentation/OpenURL && \
		cp -r ./OpenURL/Developer/Autodocs/* ${OS4_SDK_PATH}/local/Documentation/OpenURL && \
		rm -rf /tmp/*;