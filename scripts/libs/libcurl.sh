#!/usr/bin/bash
# 

echo "---> Install libCurl";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libcurl.lha" -o /tmp/libcurl.lha && \
		lha -xfq2 libcurl.lha && \
		cp -r ./SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mv ./Docs ${OS4_SDK_PATH}/local/Documentation/libcurl && \
		rm -rf /tmp/*;