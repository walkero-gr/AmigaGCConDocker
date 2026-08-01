#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install sqlite3${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://aminet.net/biz/dbase/sqlite-3.34.0.a-amiga.lha" -o /tmp/sqlite.lha && \
		lha -xfq2 sqlite.lha && \
		cp -r ./sqlite-3.34.0.a-amiga/build-m68k-amigaos/include/* ${SDK_PATH}/include/ && \
		cp -r ./sqlite-3.34.0.a-amiga/build-m68k-amigaos/lib/* ${SDK_PATH}/lib/ && \
		mkdir ${SDK_PATH}/doc/sqlite3 && \
		mv ./sqlite-3.34.0.a-amiga/LICENSE.md ${SDK_PATH}/doc/sqlite3/ && \
		mv ./sqlite-3.34.0.a-amiga/README.amiga ${SDK_PATH}/doc/sqlite3/ && \
		mv ./sqlite-3.34.0.a-amiga/README.md ${SDK_PATH}/doc/sqlite3/ && \
		mv ./sqlite-3.34.0.a-amiga/VERSION ${SDK_PATH}/doc/sqlite3/ && \
		rm -rf /tmp/*;
