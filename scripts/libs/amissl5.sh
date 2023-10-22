#!/usr/bin/bash
# 

echo "---> Install AmiSSL SDK";
	curl -fsSL "https://github.com/jens-maus/amissl/releases/download/5.11/AmiSSL-5.11-SDK.lha" -o /tmp/AmiSSL.lha && \
		lha -xfq2 AmiSSL.lha && \
		cp -r ./AmiSSL/Developer/include/* ${OS4_SDK_PATH}/include/include_h/ && \
		cp -r ./AmiSSL/Developer/xml/* ${OS4_SDK_PATH}/include/interfaces/ && \
		cp -r ./AmiSSL/Developer/lib/AmigaOS4/clib2/* ${OS4_SDK_PATH}/local/clib2/lib/ && \
		cp -r ./AmiSSL/Developer/lib/AmigaOS4/newlib/* ${OS4_SDK_PATH}/local/newlib/lib/ && \
		rm -rf /tmp/*;