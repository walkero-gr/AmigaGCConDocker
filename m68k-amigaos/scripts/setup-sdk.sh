#!/usr/bin/bash
set -e				# Exit on error

mkdir -p ${SDK_PATH}/include ${SDK_PATH}/lib ${SDK_PATH}/doc
cd /tmp

echo -e "${CCPINK}${CCBOLD}\n---> Install required tools ${CCEND}"
PACKAGES="\
	ca-certificates \
	curl"

apt-get update && apt-get -y dist-upgrade && \
	apt-get -y --no-install-recommends install $PACKAGES

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install libraries${CCEND}";
find /scripts/libs -type f -name '*.sh' | sort | while read i; do
	bash "$i"
done
