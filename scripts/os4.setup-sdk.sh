#!/usr/bin/bash

apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	gpg;
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;


mkdir -p $OS4_SDK_PATH
cd /tmp

# Install AmigaOS 4 SDK
echo "---> Install AmigaOS 4 SDK";
	curl -fskSL "https://www.hyperion-entertainment.com/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=127&amp;Itemid=127" -o /tmp/AmigaOS4-SDK.lha && \
		lha -xfq2 AmigaOS4-SDK.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/exec*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/newlib*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/clib2*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/base.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/pthreads*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/SDI-*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/cairo-*.lha && \
		lha -xfq2w=$OS4_SDK_PATH SDK_Install/expat-*.lha && \
		cp -r $OS4_SDK_PATH/Examples/Locale/include/internal/* $OS4_SDK_PATH/Include/include_h/ && \
		mv $OS4_SDK_PATH/Include/ $OS4_SDK_PATH/include/ && \
		cp -r $OS4_SDK_PATH/Local/* $OS4_SDK_PATH/local/;
	
	rm -rf $OS4_SDK_PATH/Local $OS4_SDK_PATH/C $OS4_SDK_PATH/Data $OS4_SDK_PATH/S \
			$OS4_SDK_PATH/*.info;
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


echo "-> Install libraries for newlib, clib2 and clib4";
find /scripts/libs -type f -name '*.sh' | while read i; do
	bash "$i"
done
