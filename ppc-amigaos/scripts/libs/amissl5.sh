#!/usr/bin/bash
#
set -e

# https://github.com/jens-maus/amissl/releases
echo -e "${CCPINK}${CCBOLD}\n---> Install AmiSSL SDK${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://aminet.net/util/libs/AmiSSL-v5-SDK.lha" -o /tmp/AmiSSL.lha && \
		lha -xfq2 AmiSSL.lha && \
		cp -r ./AmiSSL/Developer/include/* ${SDK_PATH}/include/include_h/ && \
		cp -r ./AmiSSL/Developer/xml/* ${SDK_PATH}/include/interfaces/ && \
		cp -r ./AmiSSL/Developer/lib/AmigaOS4/clib2/* ${SDK_PATH}/local/clib2/lib/ && \
		cp -r ./AmiSSL/Developer/lib/AmigaOS4/newlib/* ${SDK_PATH}/local/newlib/lib/ && \
		rm -rf /tmp/*;
