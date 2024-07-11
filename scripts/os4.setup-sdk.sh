#!/usr/bin/bash

apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	gpg;
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;


mkdir -p $SDK_PATH
cd /tmp

# Install AmigaOS 4 SDK
echo -e "${CCPINK}${CCBOLD}\n---> Install AmigaOS 4 SDK${CCEND}";
	curl -fskSL "https://www.hyperion-entertainment.com/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=127&amp;Itemid=127" -o /tmp/AmigaOS4-SDK.lha && \
		lha -xfq2 AmigaOS4-SDK.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/exec*.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/newlib*.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/clib2*.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/base.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/pthreads*.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/SDI-*.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/cairo-*.lha && \
		lha -xfq2w=$SDK_PATH SDK_Install/expat-*.lha && \
		cp -r $SDK_PATH/Examples/Locale/include/internal/* $SDK_PATH/include/include_h/ && \
		cp -r $SDK_PATH/Local/* $SDK_PATH/local/ && \
		cp -r $SDK_PATH/Include/* $SDK_PATH/include/;
	
	rm -rf $SDK_PATH/Local $SDK_PATH/C $SDK_PATH/Data $SDK_PATH/S \
		$SDK_PATH/*.info $SDK_PATH/Include;
	rm -rf /tmp/*;

	# Necessary links
	ln -s $SDK_PATH/clib2/lib/libamiga.a 	$SDK_PATH/newlib/lib/
	ln -s $SDK_PATH/clib2/lib/libamiga.a 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/clib2/lib/libamiga.a 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/clib2/lib/libdebug.a 	$SDK_PATH/newlib/lib/
	ln -s $SDK_PATH/clib2/lib/libdebug.a 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/clib2/lib/libdebug.a 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/crtbegin.o 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/crtend.o 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/crtend.o 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/libauto.a 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/libauto.a 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/libc.a 		$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/libm.a 		$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/libm.a 		$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/librauto.a 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/librauto.a 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/libsocket.a 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/libsocket.a 	$SDK_PATH/newlib/lib/small-data/
	ln -s $SDK_PATH/newlib/lib/libunix.a 	$SDK_PATH/newlib/lib/baserel/
	ln -s $SDK_PATH/newlib/lib/libunix.a 	$SDK_PATH/newlib/lib/small-data/


echo -e "${CCPINK}${CCBOLD}\n---> Install libraries for newlib, clib2 and clib4${CCEND}";
find /scripts/libs -type f -name '*.sh' | while read i; do
	bash "$i"
done
