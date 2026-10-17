#!/usr/bin/bash
#
set -e

# https://github.com/jens-maus/libcodesets/releases
echo -e "${CCPINK}${CCBOLD}\n---> Install codesets library${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://os4depot.net/share/library/misc/codesets.lha" -o /tmp/codesets.lha && \
		lha -xfq2 codesets.lha && \
		cp -r ./codesets/Developer/include/* ${SDK_PATH}/local/common/include/ && \
		mkdir -p ${SDK_PATH}/local/Documentation/codesets && \
		cp -r ./codesets/Developer/Autodocs/* ${SDK_PATH}/local/Documentation/codesets && \
		mkdir -p ${SDK_PATH}/local/examples/codesets && \
		cp -r ./codesets/Developer/Examples/* ${SDK_PATH}/local/examples/codesets && \
		rm -rf /tmp/*;
