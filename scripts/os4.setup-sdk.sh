#!/usr/bin/bash

apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	gpg;

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

OS4_SDK_PATH="/opt/sdk/ppc-amigaos"
mkdir -p $OS4_SDK_PATH

CLIB2_PACKAGES="\
	agg-clib2			\
	amigaos4-clib2		\
	freetype2-clib2		\
	gdbm-clib2			\
	gmp-clib2			\
	jansson-clib2		\
	jpeg9d-clib2		\
	libbz2-clib2		\
	libcairo-clib2		\
	libcares-clib2		\
	libexpat-clib2		\
	libflac-clib2		\
	libfontconfig-clib2	\
	libharfbuzz-clib2	\
	libicu-clib2		\
	libidn2-clib2		\
	libmad-clib2		\
	libmodplug-clib2	\
	libogg-clib2		\
	libopenjp2-clib2	\
	libpng16-clib2		\
	libpsl-clib2		\
	libsdl2-clib2		\
	libsdl2-image-clib2	\
	libsdl2-mixer-clib2	\
	libsdl2-net-clib2	\
	libsdl2-ttf-clib2	\
	libtiff-clib2		\
	libunistring-clib2	\
	libvorbis-clib2		\
	libxml2-clib2		\
	libxslt-clib2		\
	little-cms-clib2	\
	mpeg123-clib2		\
	openal-clib2		\
	pcre-clib2			\
	pcre2-clib2			\
	pixman1-clib2		\
	theora-clib2		\
	zlib-clib2"

cd /tmp

# Install MUI 5.0 SDK
echo "-> Install MUI 5.0 SDK";
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4.lha" -o /tmp/MUI-5.0.lha && \
	lha -xfq2 MUI-5.0.lha; \
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha && \
	lha -xfq2 MUI-5.0-contrib.lha; \
	mv ./SDK/MUI /opt/sdk/MUI_5.0; \
	rm -rf /tmp/*;

# Install AmigaOS 4 SDK
echo "-> Install AmigaOS 4 SDK";
	curl -fskSL "https://www.hyperion-entertainment.com/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=127&amp;Itemid=127" -o /tmp/AmigaOS4-SDK.lha && \
		lha -xfq2 AmigaOS4-SDK.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/exec*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/newlib*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/base.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/pthreads*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/SDI-*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/cairo-*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/expat-*.lha && \
		cp -r $OS4_SDK_PATH/Examples/Locale/include/internal/* $OS4_SDK_PATH/Include/include_h/ && \
		mv $OS4_SDK_PATH/Include/ $OS4_SDK_PATH/include/ && \
		cp -r $OS4_SDK_PATH/Local/* $OS4_SDK_PATH/local/;

	if [ X"$CLIB2_REPO" = X"afxgroup" ]; then
		echo "---> Install afxgroup clib2"
		# curl -fskSL "https://github.com/afxgroup/clib2/releases/download/v1.0.0-beta-9/clib2.lha" -o /tmp/clib2-afxgroup.lha; \
		# lha -xfq2w=$OS4_SDK_PATH clib2-afxgroup.lha;
		
		# Install clib2 and libraries from afxgroup's Ubuntu repo. 
		# They are saved under /user/ppc-amigaos
		curl -fsSL https://clib2pkg.amigasoft.net/ubuntu/clib2.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/clib2.gpg && \
			echo "deb https://clib2pkg.amigasoft.net/ubuntu/ focal main" | tee /etc/apt/sources.list.d/clib2.list && \
			apt-get update && apt-get -y --no-install-recommends install $CLIB2_PACKAGES

		\cp -r /usr/ppc-amigaos/SDK/clib2 $OS4_SDK_PATH
		\cp -r /usr/ppc-amigaos/SDK/local/* /opt/sdk/ppc-amigaos/local/
		rm $OS4_SDK_PATH/local/clib2/lib/libpthread.a
	else
		echo "---> Install adtools clib2"
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/clib2*.lha
	fi;
	
	rm -rf $OS4_SDK_PATH/Local $OS4_SDK_PATH/C $OS4_SDK_PATH/Data $OS4_SDK_PATH/S \
			$OS4_SDK_PATH/AmigaOS\ 4.1\ SDK.pdf.info \
			$OS4_SDK_PATH/Documentation.info;
	rm -rf /tmp/*;

	# Necessary links
	ln -s $OS4_SDK_PATH/clib2/lib/libamiga.a 	$OS4_SDK_PATH/newlib/lib/
	ln -s $OS4_SDK_PATH/clib2/lib/libamiga.a 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/clib2/lib/libamiga.a 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/clib2/lib/libdebug.a 	$OS4_SDK_PATH/newlib/lib/
	ln -s $OS4_SDK_PATH/clib2/lib/libdebug.a 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/clib2/lib/libdebug.a 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/crtbegin.o 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/crtend.o 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/crtend.o 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/libauto.a 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/libauto.a 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/libc.a 		$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/libm.a 		$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/libm.a 		$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/librauto.a 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/librauto.a 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/libsocket.a 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/libsocket.a 	$OS4_SDK_PATH/newlib/lib/small-data/
	ln -s $OS4_SDK_PATH/newlib/lib/libunix.a 	$OS4_SDK_PATH/newlib/lib/baserel/
	ln -s $OS4_SDK_PATH/newlib/lib/libunix.a 	$OS4_SDK_PATH/newlib/lib/small-data/



# Install SDL SDK
echo "-> Install SDL SDK";
	curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v1.2.16-rc2-amigaos4/SDL.lha" -o /tmp/SDL.lha && \
		lha -xfq2 SDL.lha && \
		cp -r ./SDL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mv ./SDL/docs ${OS4_SDK_PATH}/local/Documentation/SDL && \
		rm -rf /tmp/*;

# Install SDL2 SDK
echo "-> Install SDL2 SDK";
	curl -fsSL "https://github.com/AmigaPorts/SDL-2.0/releases/download/v2.26.5-release-amigaos4/SDL2.lha" -o /tmp/SDL2.lha && \
		lha -xfq2 SDL2.lha && \
		cp -r ./SDL2/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/SDL2 && \
		mv ./SDL2/LICENSE.txt ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/README-SDL.txt ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/README-amigaos4.md ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/WhatsNew.txt ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
		rm -rf /tmp/*;

# Install GL4ES SDK
echo "-> Install GL4ES SDK";
	curl -fsSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.2/gl4es_sdk-1.2.lha" -o /tmp/gl4es_sdk.lha && \
		lha -xfq2 gl4es_sdk.lha && \
		cp -r ./SDK/local/newlib/* ${OS4_SDK_PATH}/local/newlib/ && \
		mv ./SDK/local/common/include/GL ${OS4_SDK_PATH}/local/common/include/GL4ES && \
		mv ./SDK/Documentation/GL4ES ${OS4_SDK_PATH}/local/Documentation/ && \
		mv ./SDK/Examples/GL4ES ${OS4_SDK_PATH}/Examples && \
		rm -rf /tmp/*;

# Install libCurl
echo "-> Install libCurl";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libcurl.lha" -o /tmp/libcurl.lha && \
		lha -xfq2 libcurl.lha && \
		cp -r ./SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mv ./Docs ${OS4_SDK_PATH}/local/Documentation/libcurl && \
		rm -rf /tmp/*;

# Install jansson library
echo "-> Install jansson library";
	curl -fsSL "http://amiga-projects.net/jansson_library_2.12.1_sdk.lha" -o /tmp/jansson.lha && \
		lha -xfq2 jansson.lha && \
		cp -r ./local/* ${OS4_SDK_PATH}/local/ && \
		rm -rf /tmp/*;

# Install libopenssl
echo "-> Install libopenssl";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libopenssl.lha" -o /tmp/libopenssl.lha && \
		lha -xfq2 libopenssl.lha && \
		cp -r ./libOpenSSL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		rm -rf /tmp/*;

# Install sqlite3
echo "-> Install sqlite3";
	curl -fsSL "http://aminet.net/biz/dbase/sqlite-3.34.0-amiga.lha" -o /tmp/sqlite.lha && \
		lha -xfq2 sqlite.lha && \
		cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/include/* ${OS4_SDK_PATH}/local/common/include/ && \
		cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/lib/* ${OS4_SDK_PATH}/local/newlib/lib/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/sqlite3 && \
		mv ./sqlite-3.34.0-amiga/LICENSE.md ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/README.amiga ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/README.md ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		mv ./sqlite-3.34.0-amiga/VERSION ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
		rm -rf /tmp/*;

# Install latest MiniGL
echo "-> Install latest MiniGL";
	curl -fsSL "http://os4depot.net/share/driver/graphics/minigl.lha" -o /tmp/minigl.lha && \
		lha -xfq2 minigl.lha && \
		cp -r ./MiniGL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/minigl && \
		mv ./MiniGL/License.txt ${OS4_SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/README ${OS4_SDK_PATH}/local/Documentation/minigl/ && \
		mv ./MiniGL/demos ${OS4_SDK_PATH}/Examples/minigl && \
		rm -rf /tmp/*;

# Install libz
echo "-> Install libz";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libz.lha" -o /tmp/libz.lha && \
		lha -xfq2 libz.lha && \
		cp -r ./Zlib/SDK/Local/* ${OS4_SDK_PATH}/local/ && \
		mkdir ${OS4_SDK_PATH}/local/Documentation/libz && \
		mv ./Zlib/README ${OS4_SDK_PATH}/local/Documentation/libz/ && \
		rm -rf /tmp/*;

# Install liblua
echo "-> Install liblua";
	curl -fsSL "http://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
		lha -xfq2 liblua.lha && \
		cp -r ./SDK/local/* ${OS4_SDK_PATH}/local/ && \
		rm -rf /tmp/*;

# Install AmiSSL SDK
echo "-> Install AmiSSL SDK";
	curl -fsSL "https://github.com/jens-maus/amissl/releases/download/5.9/AmiSSL-5.9-SDK.lha" -o /tmp/AmiSSL.lha && \
		lha -xfq2 AmiSSL.lha && \
		cp -r ./AmiSSL/Developer/include/* ${OS4_SDK_PATH}/include/include_h/ && \
		cp -r ./AmiSSL/Developer/xml/* ${OS4_SDK_PATH}/include/interfaces/ && \
		cp -r ./AmiSSL/Developer/lib/AmigaOS4/clib2/* ${OS4_SDK_PATH}/local/clib2/lib/ && \
		cp -r ./AmiSSL/Developer/lib/AmigaOS4/newlib/* ${OS4_SDK_PATH}/local/newlib/lib/ && \
		rm -rf /tmp/*;

# Install codesets library
echo "-> Install codesets library";
	curl -fsSL "https://github.com/jens-maus/libcodesets/releases/download/6.21/codesets-6.21.lha" -o /tmp/codesets.lha && \
		lha -xfq2 codesets.lha && \
		cp -r ./codesets/Developer/include/* ${OS4_SDK_PATH}/local/common/include/ && \
		mkdir -p ${OS4_SDK_PATH}/local/Documentation/codesets && \
		cp -r ./codesets/Developer/Autodocs/* ${OS4_SDK_PATH}/local/Documentation/codesets && \
		mkdir -p ${OS4_SDK_PATH}/local/examples/codesets && \
		cp -r ./codesets/Developer/Examples/* ${OS4_SDK_PATH}/local/examples/codesets && \
		rm -rf /tmp/*;