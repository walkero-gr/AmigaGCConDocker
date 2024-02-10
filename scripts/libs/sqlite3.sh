#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install sqlite3${CCEND}";
	curl -fsSL "http://aminet.net/biz/dbase/sqlite-3.34.0-amiga.lha" -o /tmp/sqlite.lha && \
		lha -xfq2 sqlite.lha && \
		cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/include/* ${SDK_PATH}/local/common/include/ && \
		cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/lib/* ${SDK_PATH}/local/newlib/lib/ && \
		mkdir ${SDK_PATH}/local/Documentation/sqlite3 && \
		mv ./sqlite-3.34.0-amiga/LICENSE.md ${SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/README.amiga ${SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/README.md ${SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/VERSION ${SDK_PATH}/local/Documentation/sqlite3/ && \
		rm -rf /tmp/*;