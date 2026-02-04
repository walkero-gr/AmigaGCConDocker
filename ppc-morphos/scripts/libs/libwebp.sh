#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libwebp ${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=2251646" -o libwebp.lha && \
		lha -xfq2 libwebp.lha && \
		mkdir -p /gg/include/webp/sharpyuv /gg/lib/pkgconfig/ && \
		cp -r ./libwebp-1.4.0/src/libwebp*.a /gg/lib/ && \
		cp -r ./libwebp-1.4.0/src/demux/libwebp*.a /gg/lib/ && \
		cp -r ./libwebp-1.4.0/sharpyuv/libsharpyuv.a /gg/lib/ && \
		cp -r ./libwebp-1.4.0/src/libwebp*.pc /gg/lib/pkgconfig/ && \
		cp -r ./libwebp-1.4.0/src/webp /gg/include/ && \
		cp -r ./libwebp-1.4.0/sharpyuv/sharpyuv*.h /gg/include/webp/sharpyuv && \
		rm -rf /tmp/*;