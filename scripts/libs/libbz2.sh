#!/usr/bin/bash
# 

echo "---> Install libbz2";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libbz2.lha" -o /tmp/libbz2.lha && \
		lha -xfq2 libbz2.lha && \
		cp -r ./libbz2-1.0.8/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir ${SDK_PATH}/local/Documentation/libbz2 && \
		mv ./libbz2-1.0.8/README ./libbz2-1.0.8/LICENSE ./libbz2-1.0.8/libbz2.readme ${SDK_PATH}/local/Documentation/libbz2/ && \
		rm -rf /tmp/*;