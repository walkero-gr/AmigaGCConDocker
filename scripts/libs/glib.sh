#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install glib${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/misc/glib.lha" -o /tmp/glib.lha && \
		lha -xfq2 glib.lha && \
		cp -r ./glib-2.30.1/local/* ${SDK_PATH}/local/ && \
		cp -r ./glib-2.30.1/glib-2.30.1/glib/.libs/libglib-2.0.l* \
				./glib-2.30.1/glib-2.30.1/glib/.libs/libglib-2.0.so \
				${SDK_PATH}/local/newlib/lib; \
		cp -r ./glib-2.30.1/glib-2.30.1/gmodule/.libs/libgmodule-2.0.l* \
				./glib-2.30.1/glib-2.30.1/gmodule/.libs/libgmodule-2.0.so \
				${SDK_PATH}/local/newlib/lib; \
		cp -r ./glib-2.30.1/glib-2.30.1/gobject/.libs/libgobject-2.0.l* \
				./glib-2.30.1/glib-2.30.1/gobject/.libs/libgobject-2.0.so \
				${SDK_PATH}/local/newlib/lib; \
		cp -r ./glib-2.30.1/glib-2.30.1/gthread/.libs/libgthread-2.0.l* \
				./glib-2.30.1/glib-2.30.1/gthread/.libs/libgthread-2.0.so \
				${SDK_PATH}/local/newlib/lib; \
		rm -rf /tmp/*;