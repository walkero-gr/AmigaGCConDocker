#!/usr/bin/bash
# 

echo "---> Install codesets library";
	curl -fsSL "https://github.com/jens-maus/libcodesets/releases/download/6.21/codesets-6.21.lha" -o /tmp/codesets.lha && \
		lha -xfq2 codesets.lha && \
		cp -r ./codesets/Developer/include/* ${SDK_PATH}/local/common/include/ && \
		mkdir -p ${SDK_PATH}/local/Documentation/codesets && \
		cp -r ./codesets/Developer/Autodocs/* ${SDK_PATH}/local/Documentation/codesets && \
		mkdir -p ${SDK_PATH}/local/examples/codesets && \
		cp -r ./codesets/Developer/Examples/* ${SDK_PATH}/local/examples/codesets && \
		rm -rf /tmp/*;