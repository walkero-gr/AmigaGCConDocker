#!/usr/bin/bash
# 

CLIB2_PACKAGES="\
	agg-clib2             \
	amigaos4-clib2        \
	curl-clib2            \
	freetype2-clib2       \
	fribidi-clib2         \
	gdbm-clib2            \
	gettext-clib2         \
	glew-gl4es-clib2      \
	gmp-clib2             \
	jansson-clib2         \
	jpeg9d-clib2          \
	libbrotli-clib2       \
	libbz2-clib2          \
	libcairo-clib2        \
	libcares-clib2        \
	libexif-clib2         \
	libexpat-clib2        \
	libffi-clib2          \
	libflac-clib2         \
	libfmt-clib2          \
	libfontconfig-clib2   \
	libgl4es-clib2        \
	libglm-clib2          \
	libharfbuzz-clib2     \
	libicu-clib2          \
	libidn2-clib2         \
	libmad-clib2          \
	libmodplug-clib2      \
	libmp3lame-clib2      \
	libnghttp3-clib2      \
	libngtcp2-clib2       \
	libogg-clib2          \
	libopenjp2-clib2      \
	libpng16-clib2        \
	libpsl-clib2          \
	librtmp-clib2         \
	libsdl2-clib2         \
	libsdl2-image-clib2   \
	libsdl2-mixer-clib2   \
	libsdl2-net-clib2     \
	libsdl2-ttf-clib2     \
	libstb-clib2          \
	libtiff-clib2         \
	libungif-clib2        \
	libunistring-clib2    \
	libvorbis-clib2       \
	libvpx-clib2          \
	libwebp-clib2         \
	libxml2-clib2         \
	libxslt-clib2         \
	little-cms-clib2      \
	lz4-clib2             \
	mpc-clib2             \
	mpeg123-clib2         \
	mpfr-clib2            \
	openal-clib2          \
	opencore-amr-clib2    \
	opengles-clib2        \
	openssl-quic-clib2    \
	pcre-clib2            \
	pcre2-clib2           \
	pixman1-clib2         \
	theora-clib2          \
	zlib-clib2"

# Removed because of conflicts
# giflib-clib2          \
# minigl-clib2          \
# libungif-clib2        \
# openssl-clib2         \
# openssl3-clib2        \

CLIB4_PACKAGES="\
	amigaos4-clib4		\
	freetype2-clib4		\
	gdbm-clib4			\
	giflib-clib4		\
	jansson-clib4		\
	jpeg9d-clib4		\
	libagg2-clib4		\
	libbrotli-clib4		\
	libbz2-clib4		\
	libcairo-clib4		\
	libcares-clib4		\
	libdeflate-clib4	\
	libev-clib4			\
	libexif-clib4		\
	libexpat-clib4		\
	libfast-lzma2-clib4	\
	libffi-clib4		\
	libflac-clib4		\
	libfmt-clib4		\
	libgl4es-clib4		\
	libglm-clib4		\
	libharfbuzz-clib4	\
	libicu-clib4		\
	libidn2-clib4		\
	libiodbc-clib4		\
	libmad-clib4		\
	libmodplug-clib4	\
	libmp3lame-clib4	\
	libnghttp2-clib4	\
	libnghttp3-clib4	\
	libngtcp2-clib4		\
	libogg-clib4		\
	libopenjp2-clib4	\
	libpng16-clib4		\
	libpsl-clib4		\
	librtmp-clib4		\
	libstb-clib4		\
	libtiff-clib4		\
	libunistring-clib4	\
	libvorbis-clib4		\
	libwebp-clib4		\
	libxml2-clib4		\
	libxslt-clib4		\
	libxxhash-clib4		\
	little-cms-clib4	\
	lz4-clib4			\
	mpc-clib4			\
	opencore-amr-clib4	\
	opengles-clib4		\
	openssl-quic-clib4	\
	pcre-clib4			\
	pcre2-clib4			\
	pixman1-clib4		\
	sqlite-clib4		\
	theora-clib4		\
	zlib-clib4"

# Removed because of conflicts
# minigl-clib4, , libungif-clib4, libsdl2-minigl-clib4
# 
# Replaced by AmigLabs libs-ports
# mpfr-clib4
# gmp-clib4

if [ -d "$SDK_PATH/clib4" ]; then
echo "---> Install clib4 libraries";
	# curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v1.2.16-rc2-amigaos4/SDL.lha" -o /tmp/SDL.lha && \
	# 	lha -xfq2 SDL.lha && \
	# 	cp -r ./SDL/SDK/local/* ${SDK_PATH}/local/ && \
	# 	mv ./SDL/docs ${SDK_PATH}/local/Documentation/SDL && \
	# 	rm -rf /tmp/*;

	# Install clib4 libraries from afxgroup's Ubuntu repo.
	# They are saved under /user/ppc-amigaos
	dpkg --add-architecture amd64;
	curl -fsSL https://clib2pkg.amigasoft.net/ubuntu/clib4.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/clib4.gpg && \
		echo "deb [arch=amd64] https://clib2pkg.amigasoft.net/ubuntu/ focal main" | tee /etc/apt/sources.list.d/clib4.list && \
		apt-get update;
	apt-get -y --no-install-recommends -o Dpkg::Options::="--force-overwrite" install $CLIB4_PACKAGES
	\cp -r /usr/ppc-amigaos/SDK/* ${SDK_PATH}/

	# Necessary for paths in some pkgconfig files
	rm -rf /usr/ppc-amigaos && \
	mkdir -p /usr/ppc-amigaos/SDK/local && \
	ln -s $SDK_PATH/local/clib4 /usr/ppc-amigaos/SDK/local/clib4
else
echo "---> clib4 FOLDER NOT FOUND";
echo "$SDK_PATH/clib4"
fi



	# if [ X"$CLIB2_REPO" = X"afxgroup" ]; then
	# 	echo "---> Install afxgroup clib2"
	# 	# curl -fskSL "https://github.com/afxgroup/clib2/releases/download/v1.0.0-beta-9/clib2.lha" -o /tmp/clib2-afxgroup.lha; \
	# 	# lha -xfq2w=$SDK_PATH clib2-afxgroup.lha;
		
		# Install clib2 and libraries from afxgroup's Ubuntu repo. 
		# They are saved under /user/ppc-amigaos
		# dpkg --add-architecture amd64;
		# curl -fsSL https://clib2pkg.amigasoft.net/ubuntu/clib2.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/clib2.gpg && \
		# 	echo "deb [arch=amd64] https://clib2pkg.amigasoft.net/ubuntu/ focal main" | tee /etc/apt/sources.list.d/clib2.list && \
		# 	apt-get update;
		# apt-get -y --no-install-recommends install $CLIB2_PACKAGES

	# 	\cp -r /usr/ppc-amigaos/SDK/clib2 $SDK_PATH
	# 	\cp -r /usr/ppc-amigaos/SDK/local/* /opt/sdk/ppc-amigaos/local/
	# 	rm $SDK_PATH/local/clib2/lib/libpthread.a
	# else