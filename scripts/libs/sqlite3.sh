#!/usr/bin/bash
# 

echo "---> Install sqlite3";
	curl -fsSL "http://aminet.net/biz/dbase/sqlite-3.34.0-amiga.lha" -o /tmp/sqlite.lha && \
		lha -xfq2 sqlite.lha && \
		cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/include/* ${OS4_SDK_PATH}/local/common/include/ && \
		cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/lib/* ${OS4_SDK_PATH}/local/newlib/lib/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/sqlite3 && \
		mv ./sqlite-3.34.0-amiga/LICENSE.md ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/README.amiga ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/README.md ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/VERSION ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		rm -rf /tmp/*;