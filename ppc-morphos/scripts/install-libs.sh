#!/usr/bin/bash

cd /tmp
echo -e "${CCPINK}${CCBOLD}\n---> Install third-party libraries ${CCEND}";
find /scripts/libs -type f -name '*.sh' | while read i; do
	bash "$i"
done