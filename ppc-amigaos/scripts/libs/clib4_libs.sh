#!/usr/bin/bash
# 

CLIB4_PACKAGES="\
	amigaos4-clib4		\
	cppunit-clib4		\
	curl7-clib4			\
	fontconfig-clib4	\
	freetype2-clib4		\
	gdbm-clib4			\
	giflib-clib4		\
	jansson-clib4		\
	jpeg9d-clib4		\
	libagg2-clib4		\
	libass-clib4		\
	libboost-clib4		\
	libbrotli-clib4		\
	libbz2-clib4		\
	libcairo-clib4		\
	libcares-clib4		\
	libcdr-clib4		\
	libconfig-clib4		\
	libdeflate-clib4	\
	libev-clib4			\
	libexif-clib4		\
	libexpat-clib4		\
	libfast-lzma2-clib4	\
	libffi-clib4		\
	libffmpeg-clib4		\
	libflac-clib4		\
	libfmt-clib4		\
	libgl4es-clib4		\
	libglm-clib4		\
	libgme-clib4		\
	libharfbuzz-clib4	\
	libharu-clib4		\
	libicu-clib4		\
	libidn2-clib4		\
	libiodbc-clib4		\
	libmad-clib4		\
	libmd4c-clib4		\
	libmp3lame-clib4	\
	libncurses-clib4	\
	libnghttp2-clib4	\
	libnghttp3-clib4	\
	libogg-clib4		\
	libopenjp2-clib4	\
	libpbl-clib4		\
	libpsl-clib4		\
	librapidjson-clib4	\
	libraylib5-clib4	\
	libreadline8-clib4	\
	librevenge-clib4	\
	libsidplay-clib4	\
	libsndfile-clib4	\
	libstb-clib4		\
	libtiff-clib4		\
	libunistring-clib4	\
	libvorbis-clib4		\
	libvpx-clib4		\
	libwebp-clib4		\
	libx264-clib4		\
	libxml2-clib4		\
	libxslt-clib4		\
	libxvidcore-clib4	\
	libxxhash-clib4		\
	little-cms-clib4	\
	lz4-clib4			\
	mpc-clib4			\
	opencore-amr-clib4	\
	opengles-clib4		\
	openssl-quic-clib4	\
	openssl3-clib4		\
	pixman1-clib4		\
	sqlite-clib4		\
	theora-clib4		\
	zlib-clib4"

# Replaced by OS4 depot packages
	# libsdl2-image-clib4	\
	# libsdl2-net-clib4	\
	# libsdl2-ttf-clib4	\
	# libmodplug-clib4	\
	# libopus-clib4		\
	# libopusfile-clib4	\
	# libpng16-clib4		\

# Removed because of conflicts
# librtmp-clib4		\
# libngtcp2-clib4		\
# libSDL2-gl4es-clib4	\
# 
# minigl-clib4, libungif-clib4, libsdl2-minigl-clib4
# 
# Replaced by AmigLabs libs-ports
# mpfr-clib4
# gmp-clib4
# pcre-clib4
# pcre2-clib4

if [ -d "$SDK_PATH/clib4" ]; then
echo -e "${CCPINK}${CCBOLD}\n---> Install clib4 libraries${CCEND}";
	# Install clib4 libraries from afxgroup's Ubuntu repo.
	# They are saved under /user/ppc-amigaos
	dpkg --add-architecture amd64;
	curl -fsSL https://clib4pkg.amigasoft.net/ubuntu/clib4.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/clib4.gpg && \
		echo "deb [arch=amd64] https://clib4pkg.amigasoft.net/ubuntu/ focal main" | tee /etc/apt/sources.list.d/clib4.list && \
		apt-get update

	apt-get -y --no-install-recommends -o Dpkg::Options::="--force-overwrite" install $CLIB4_PACKAGES
	\cp -r /usr/ppc-amigaos/SDK/* ${SDK_PATH}/

	# Necessary for paths in some pkgconfig files
	rm -rf /usr/ppc-amigaos && \
	mkdir -p /usr/ppc-amigaos/SDK/local && \
	ln -s $SDK_PATH/local/clib4 /usr/ppc-amigaos/SDK/local/clib4

	# Delete the local/clib4/include/GL directory because of inconsistencies
	rm -rf $SDK_PATH/local/clib4/include/GL
else
echo -e "${CCRED}${CCBOLD}\n---> clib4 FOLDER NOT FOUND${CCEND}";
echo "$SDK_PATH/clib4"
fi
