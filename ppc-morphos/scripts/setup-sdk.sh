#!/usr/bin/bash
set -e				# Exit on error
set -o pipefail		# Propagate errors through pipes
set -u				# Exit on undefined variable

apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	git \
	gpg \
	unzip;
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

mkdir -p /gg/os-include/mui/

cd /tmp
echo -e "${CCPINK}${CCBOLD}\n---> Install libraries ${CCEND}";
find /scripts/libs -type f -name '*.sh' | sort | while read i; do
	bash "$i"
done
