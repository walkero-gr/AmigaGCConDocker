#!/usr/bin/bash
# 

echo "---> Install liblua";
	curl -fsSL "http://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
		lha -xfq2 liblua.lha && \
		cp -r ./SDK/local/* ${OS4_SDK_PATH}/local/ && \
		rm -rf /tmp/*;