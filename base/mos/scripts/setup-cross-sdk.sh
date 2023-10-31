#!/bin/sh
#
# setup-cross-sdk.sh version 1.11 Copyright 2013-2021 Mark Olsen
#
# Script to automatically set up a MorphOS cross compiler environment on Linux (and other Unix-oids).
#
# Newest version can be downloaded from https://bigfoot.morphos-team.net/files/setup-cross-sdk.sh
#
# History:
# 1.11 - 20220406
#  - Added a workaround for missing GCC path patching in the MorphOS SDK.
#  - Now builds libatomic.
#
# 1.10 - 20220324
#  - Now works around a bunch of new problems with broken GCC Makefiles in the SDK.
#  - Added support for GCC 10 and GCC 11.
#  - Reworked the error message output slightly. If running Debian, it will tell you what Debian packages to install.
#
# 1.9 - 20191026
#  - Now works around another problem with the broken GCC9 Makefile in the 20191006 SDK
#
# 1.8 - 20191018
#  - Now works around a broken GCC9 Makefile in the 20191006 SDK
#
# 1.7 - 20191017
#  - Now includes Perl scripts from the bin directory of the MorphOS SDK (cvinclude.pl, genfd.pl)
#  - Now also supports building GCC 5, GCC 8 and GCC 9.
#  - Now also tests for the presence of libisl.
#  - Now handles SDK archives with a GG directory of any case.
#
# 1.6 - 20190129
#  - Now supports building GCC 6 and GCC 7 as well. By default only the newest GCC version present will be built.
#  - Now supports building Binutils 2.31.1
#  - Now does a parallel build on Linux systems with more than one CPU core
#  - Now tests for the host system's ability to build 32 bit executables as well as the presence of libgmp, libmpc and libmpfr.
#  - Now supports source tarballs that have files in an sdk-source subdirectory.
#
# 1.5 - 20180531
#  - No longer applies the toplev.h patch to GCC4 if the GCC4 source archive already includes it.
#
# 1.4 - 20160129
#  - The GNU people just can't stop breaking Makeinfo, so documentation generation for GCC is now disabled to avoid Makeinfo problems.
#  - The GNU people also just can't stop breaking GCC, so a patch to let GCC build with (a newer) GCC has also been included.
#
# 1.3 - 20150812
#  - Now works on Mac OS X
#

MISSING_DEBIAN_PACKAGES=""
MISSING_FILES=""

DEBIAN_PACKAGE_MAP_ld=binutils
DEBIAN_PACKAGE_MAP_libgmp=libgmp-dev
DEBIAN_PACKAGE_MAP_libmpc=libmpc-dev
DEBIAN_PACKAGE_MAP_libmpfr=libmpfr-dev
DEBIAN_PACKAGE_MAP_lha=lhasa
DEBIAN_PACKAGE_MAP_makeinfo=texinfo

add_missing_file()
{
	eval local DEBNAME="\${DEBIAN_PACKAGE_MAP_$1}"
	if [ -z "${DEBNAME}" ]
	then
		local DEBNAME="$1"
	fi

	if [ -z "${MISSING_FILES}" ]
	then
		MISSING_DEBIAN_PACKAGES="$DEBNAME"
		MISSING_FILES="$1"
	else
		MISSING_DEBIAN_PACKAGES="${MISSING_DEBIAN_PACKAGES} $DEBNAME"
		MISSING_FILES="${MISSING_FILES}, $1"
	fi
}

show_missing_files()
{
	if [ ! -z "${MISSING_FILES}" ]
	then
		echo "The following programs are missing: ${MISSING_FILES}"

		if [ "$(lsb_release -s -i)" = "Debian" ]
		then
			echo "You can install these programs by running the following command: apt-get install ${MISSING_DEBIAN_PACKAGES}"
		fi
	fi
}

patch_atomic()
{
	local GCC_VERSION="$1"

	sed -i -e 's/^\(+#define LIB_SPEC.*\) -latomic/\1/' "${TMPDIR}/gcc${GCC_VERSION}/gcc-${GCC_VERSION}-morphos.diff"
}

patch_makefile_fix_fenv_for_crossbuild()
{
	local GCC_VERSION="$1"

	if test -f "${TMPDIR}/gcc${GCC_VERSION}/fix-fenv-for-crossbuild.diff" && ! grep -q "fix-fenv-for-crossbuild\.diff" "${TMPDIR}/gcc${GCC_VERSION}/Makefile"
	then
		echo "Applying fix-fenv-for-crossbuild.diff fixup." >>"$CURDIR/setup-cross-sdk.log"
		sed -i -e "s,^\(.*\)(cd \(.*\) && patch -p1) <fix-genericize_if_stmt-ice.diff,& \&\& (cd \2 \&\& patch -p1) <fix-fenv-for-crossbuild.diff," "${TMPDIR}/gcc${GCC_VERSION}/Makefile" >>"$CURDIR/setup-cross-sdk.log" 2>&1 || ERROR=1
	else
		echo "Not applying fix-fenv-for-crossbuild.diff fixup." >>"$CURDIR/setup-cross-sdk.log"
	fi
}

patch_gcc_lib_path_fixup()
{
	local GCC_VERSION="$1"

	if ! grep -q "find gcc.*-name configure" "${TMPDIR}/gcc${GCC_VERSION}/Makefile"
	then
		echo "Applying gcc-lib path fixup." >>"$CURDIR/setup-cross-sdk.log"
		local GCC_FULL_VERSION="$(grep "^gcc-[^/]*/.morphos-sources-stamp:" "${TMPDIR}/gcc${GCC_VERSION}/Makefile" | sed "s,^gcc-\([^/]*\)/.morphos-sources-stamp:.*$,\1,")"
		test -z "$ERROR" && (cd "$TMPDIR/gcc${GCC_VERSION}" && make "gcc-${GCC_FULL_VERSION}/.morphos-sources-stamp" >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
		test -z "$ERROR" && (find "${TMPDIR}/gcc${GCC_VERSION}/gcc-${GCC_FULL_VERSION}" -name configure -print0 | xargs -0 -r perl -i.orig -p -e "s|toolexecdir='\\\$\(libdir\)/gcc/\\\$\(target_alias\)'|toolexecdir='\\\$(libdir)/gcc-lib/\\\$(target_alias)'|g;") >>"$CURDIR/setup-cross-sdk.log" 2>&1 || ERROR=1
		test -z "$ERROR" && (find "${TMPDIR}/gcc${GCC_VERSION}/gcc-${GCC_FULL_VERSION}" -name Makefile.in -print0 | xargs -0 -r perl -i.orig -p -e "s|= \\\$\(libexecdir\)/gcc/\\\$\(real_target_noncanonical\)|= \\\$(libexecdir)/gcc-lib/\\\$(real_target_noncanonical)|g;s|= \\\$\(libdir\)/gcc/\\\$\(target_noncanonical\)|= \\\$(libdir)/gcc-lib/\\\$(target_noncanonical)|g;") >>"$CURDIR/setup-cross-sdk.log" 2>&1 || ERROR=1
	else
		echo "Not applying gcc-lib path fixup." >>"$CURDIR/setup-cross-sdk.log"
	fi
}

GCC4=n
GCC5=n
GCC6=n
GCC7=n
GCC8=n
GCC9=n
GCC10=n
GCC11=n

MAKEPARALLEL=""

if [ -f /proc/cpuinfo ]
then
	MAKEPARALLEL="-j `grep -c "^processor\s*:" /proc/cpuinfo`"
fi

while [ $# -gt 0 ]
do
	case "$1" in
		"--help")
			echo "\t--force     | Removes previous SDK installation before installing the current one"
			echo "\t--gcc4      | Builds GCC 4"
			echo "\t--gcc5      | Builds GCC 5"
			echo "\t--gcc6      | Builds GCC 6"
			echo "\t--gcc7      | Builds GCC 7"
			echo "\t--gcc8      | Builds GCC 8"
			echo "\t--gcc9      | Builds GCC 9"
			echo "\t--gcc10     | Builds GCC 10"
			echo "\t--gcc11     | Builds GCC 11"
			echo
			echo "Multiple GCC versions can be selected. By default only the newest GCC version available in the source archive will be built."
			ERROR=1
			;;
		"--force")
			FORCE=y
			;;

		"--gcc4")
			GCC4=y
			;;

		"--gcc5")
			GCC5=y
			;;

		"--gcc6")
			GCC6=y
			;;

		"--gcc7")
			GCC7=y
			;;

		"--gcc8")
			GCC8=y
			;;

		"--gcc9")
			GCC9=y
			;;

		"--gcc10")
			GCC10=y
			;;

		"--gcc11")
			GCC11=y
			;;

		*)
			echo "Unknown argument \"$1\""
			ERROR=1
			;;
	esac

	shift
done

if [ ! -z "$ERROR" ]
then
	exit 1
fi

if [ ! -d "/gg" ]
then
	echo "/gg doesn't exist. Please create it and chown it to your user."
	ERROR=1
fi

if [ ! -O "/gg" ]
then
	echo "/gg isn't owned by you. Please chown it to your user."
	ERROR=1
fi

if [ ! -w "/gg" ]
then
	echo "/gg isn't writable by you. Please chmod u+w /gg";
	ERROR=1;
fi

if ! echo $PATH | grep -q /gg/bin
then
	echo "/gg/bin isn't in your \$PATH. Please add it by typing \"export PATH=\$PATH:/gg/bin\"."
	ERROR=1
fi

for i in bison bzip2 flex gcc g++ ld lha m4 make makeinfo patch xz
do
	if [ -z "`which $i`" ]
	then
		add_missing_file ${i}
		ERROR=1
	fi
done

if [ -z "$FORCE" ]
then
	if [ -d /gg/include ] || [ -d /gg/os-include ] || [ -d /gg/includestd ] || [ -d /gg/ppc-morphos ]
	then
		echo "You already have an SDK installed in /gg. Either remove the old SDK manually or use --force to automatically overwrite it."
		ERROR=1
	fi
fi

if [ ! -z "$ERROR" ]
then
	show_missing_files
	exit 1
fi

SDKSOURCE="`ls sdk-source-????????.tar.xz | head -n 1`"
SDKVERSION=`echo "$SDKSOURCE" | sed "s/sdk-source-\(........\)\.tar\.xz/\1/"`
SDK="sdk-$SDKVERSION.lha"

if [ ! -f "$SDK" ] || [ ! -f "$SDKSOURCE" ]
then
	echo "Unable to find the SDK files."
	echo "Please download the SDK and the corresponding SDK source code files from"
	echo "http://www.morphos-team.net/ and place them in the current directory."

	exit 1
fi

if [ -z "$SDKVERSION" ]
then
	echo "Unable to detect SDK version."
	exit 1
fi

echo "Using SDK version: $SDKVERSION."

if [ "`uname`" = "Darwin" ]
then
	TMPDIR="`mktemp -d -t setupcrosssdk`"
else
	TMPDIR="`mktemp -d`"
fi
CURDIR="`pwd`"

if [ -z "$TMPDIR" ]
then
	echo "Unable to create temporary directory."
	exit 1
fi

trap "rm -rf \"$TMPDIR\"" exit

echo "int main(){}" >"$TMPDIR/test.c"

for i in gmp mpc mpfr
do
	if ! gcc  "$TMPDIR/test.c" -l$i -o /dev/null >/dev/null 2>&1
	then
		add_missing_file lib${i}
		ERROR=1
	fi
done

if [ ! -z "$ERROR" ]
then
	show_missing_files
	exit 1
fi

if [ -d /gg/include ] || [ -d /gg/os-include ] || [ -d /gg/includestd ] || [ -d /gg/ppc-morphos ]
then
	echo "Removing old SDK installation."
	rm -rf /gg/include /gg/os-include /gg/includestd /gg/ppc-morphos
fi

echo "Extracting SDK files."

# Extract files for /gg
(cd "$TMPDIR" && lha -x "$CURDIR/$SDK" "morphossdk/sdk.pack" >/dev/null && xz -dcf morphossdk/sdk.pack | (cd /gg && tar --wildcards --transform "s,^Development/[Gg][Gg]/,," --exclude "ldscripts" -x "Development/[Gg][Gg]/ppc-morphos" "Development/[Gg][Gg]/include" "Development/[Gg][Gg]/includestd" "Development/[Gg][Gg]/os-include" "Development/[Gg][Gg]/bin/*.pl")) || exit 1

if echo "`tar -tf "$CURDIR/$SDKSOURCE" | head -n 1`" | grep -q "^sdk-source/"
then
	SOURCETARBALLPREFIX="sdk-source/"
else
	SOURCETARBALLPREFIX=""
fi

if [ "$GCC4" != "y" ] && [ "$GCC5" != "y" ] && [ "$GCC6" != "y" ] && [ "$GCC7" != "y" ] && [ "$GCC8" != "y" ] && [ "$GCC9" != "y" ] && [ "${GCC10}" != "y" ] && [ "${GCC11}" != "y" ]
then
	SDKGCCVERSION=gcc`tar -tf "$CURDIR/$SDKSOURCE" | sed "s,^sdk-source/,," | grep "^gcc\(4\|5\|6\|7\|8\|9\|10\|11\)/" | sed "s,/.*,," | sed "s,^gcc,," | sort -n | uniq | tail -n 1`

	if [ -z "$SDKGCCVERSION" ]
	then
		echo "Unable to find a supported GCC version in the SDK source archive."
		exit 1
	fi

	case "$SDKGCCVERSION" in
		"gcc4")
			GCC4="y"
			;;

		"gcc5")
			GCC5="y"
			;;

		"gcc6")
			GCC6="y"
			;;

		"gcc7")
			GCC7="y"
			;;

		"gcc8")
			GCC8="y"
			;;

		"gcc9")
			GCC9="y"
			;;

		"gcc10")
			GCC10="y"
			;;

		"gcc11")
			GCC11="y"
			;;
	esac
fi

GCCVERSIONS=""
if [ "$GCC4" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc4"
fi

if [ "$GCC5" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc5"
fi

if [ "$GCC6" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc6"
fi

if [ "$GCC7" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc7"
fi

if [ "$GCC8" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc8"
fi

if [ "$GCC9" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc9"
fi

if [ "$GCC10" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc10"
fi

if [ "$GCC11" = "y" ]
then
	GCCVERSIONS="$GCCVERSIONS ${SOURCETARBALLPREFIX}gcc11"
fi

# Extract the Binutils/GCC source code.
(cd "$TMPDIR" && tar --transform "s,^sdk-source/,," -xf "$CURDIR/$SDKSOURCE" ${SOURCETARBALLPREFIX}binutils $GCCVERSIONS) || ERROR=1
if [ ! -z "$ERROR" ]
then
	echo "Failed to extract SDK source archive."
	exit 1
fi

rm -f "${CURDIR}/setup-cross-sdk.log"

# Build Binutils
echo "Building binutils."

if [ -f "$TMPDIR/binutils/ld/configure" ] && grep -q "^VERSION=2\.9\.1$" "$TMPDIR/binutils/ld/configure"
then
	# Check if the installed GCC can compile 32 bit executables

	if ! gcc -m32 "$TMPDIR/test.c" -o /dev/null >"$CURDIR/setup-cross-sdk.log" 2>&1
	then
		echo "Your system seems unable to compile 32 bit executables which is required for this version of Binutils."
		if [ -f /etc/debian_version ]
		then
			echo "You can run the following command to install 32 bit support for GCC: apt-get install libc6-dev-i386"
		fi
		echo "Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi

	# Apply some workarounds to Binutils 2.9.1

	# Fortify on Ubuntu, which is enabled by default, detects phantom errors which according to Valgrind don't exist. Adding -U_FORTIFY_SOURCE to avoid this.
	(cd "$TMPDIR/binutils" && CFLAGS="-m32 -O2 -U_FORTIFY_SOURCE" ./configall >"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	# Are we Mac OS X? Apply some dubious patches to try to get this to build...
	if [ "`uname`" = "Darwin" ]
	then
		DARWINCFLAGS="-fno-builtin"

		cat <<EOF | (cd "$TMPDIR/binutils/include" && patch -p0)
--- libiberty.h.orig    2015-06-19 16:07:57.000000000 +0300
+++ libiberty.h 2015-08-12 20:56:54.000000000 +0300
@@ -108,7 +108,7 @@
 
 /* Exit, calling all the functions registered with xatexit.  */
 
-#ifndef __GNUC__
+#ifndef __NOTREALLYGNUC__
 extern void xexit PARAMS ((int status));
 #else
 typedef void libiberty_voidfn PARAMS ((int status));
EOF

		cat <<EOF | (cd "$TMPDIR/binutils/libiberty" && patch -p0)
--- strerror.c.orig     2015-06-19 16:07:59.000000000 +0300
+++ strerror.c  2015-08-12 20:59:35.000000000 +0300
@@ -466,7 +466,7 @@
 
 #else
 
-extern int sys_nerr;
+extern const int sys_nerr;
 extern char *sys_errlist[];
 
 #endif
EOF

	fi

	test -z "$ERROR" && (cd "$TMPDIR/binutils/build" && make CFLAGS="-m32 -O2 -U_FORTIFY_SOURCE $DARWINCFLAGS" >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/binutils/build" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	# Set up required Binutils symlinks
	mkdir -p /gg/ppc-morphos/bin

	for i in ar as ld nm objdump ranlib
	do
		ln -s /gg/bin/ppc-morphos-$i /gg/ppc-morphos/bin/$i
	done
else
	# Other (newer) versions of Binutils should build with fewer workarounds

	sed -i -e 's/^include .*SDK.global$//' "$TMPDIR/binutils/Makefile"

	test -z "$ERROR" && (cd "$TMPDIR/binutils" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/binutils/build" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
fi

if [ ! -z "$ERROR" ]
then
	echo "Failed to build Binutils for whatever reason. You're unfortunately on"
	echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
	exit 1
fi

if [ "$GCC4" = "y" ]
then
	# Build GCC 4
	echo "Building GCC 4."

	test -z "$ERROR" && (cd "$TMPDIR/gcc4" && make gcc4_unpack >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	# Are we Mac OS X? Apply some dubious patches to try to get this to build...
	if [ "`uname`" = "Darwin" ]
	then
		test -z "$ERROR" && (cd "$TMPDIR/gcc4" && make mpfr_unpack >"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

		cat <<EOF | (cd "$TMPDIR/gcc4" && patch -p0) >>"$CURDIR/setup-cross-sdk.log" 2>&1
--- Makefile.orig       2015-06-19 16:09:13.000000000 +0300
+++ Makefile    2015-08-12 21:32:17.000000000 +0300
@@ -85,7 +85,7 @@
 
 # GCC v4
 
-gcc4: gmp_install mpfr_install gcc4_unpack gcc4_patch gcc4_dir gcc4_configure gcc4_make
+gcc4: mpfr_install gcc4_unpack gcc4_patch gcc4_dir gcc4_configure gcc4_make
 
 GCC4_DIR = gcc-4.4.5
 
EOF

		cat <<EOF | (cd "$TMPDIR/gcc4/mpfr-3.0.0" && patch -p0) >>"$CURDIR/setup-cross-sdk.log" 2>&1
--- mpfr.h.orig 2010-06-10 14:00:14.000000000 +0300
+++ mpfr.h      2015-08-12 21:35:58.000000000 +0300
@@ -23,6 +23,8 @@
 #ifndef __MPFR_H
 #define __MPFR_H
 
+#define __gmp_const const
+
 /* Define MPFR version number */
 #define MPFR_VERSION_MAJOR 3
 #define MPFR_VERSION_MINOR 0
EOF

	fi

	if [ ! -f "$TMPDIR/gcc4/patch/0013-toplev-inline.patch" ]
	then
		cat <<EOF | (cd "$TMPDIR/gcc4/gcc-4.4.5/gcc" && patch -p0)
--- toplev.h.orig       2009-02-20 17:20:38.000000000 +0200
+++ toplev.h    2015-08-12 21:24:42.000000000 +0300
@@ -174,7 +174,7 @@
 extern int floor_log2                  (unsigned HOST_WIDE_INT);
 
 /* Inline versions of the above for speed.  */
-#if GCC_VERSION >= 3004
+#if NOTREALLYGCC_VERSION >= 3004
 # if HOST_BITS_PER_WIDE_INT == HOST_BITS_PER_LONG
 #  define CLZ_HWI __builtin_clzl
 #  define CTZ_HWI __builtin_ctzl
EOF
	fi

	test -z "$ERROR" && (cd "$TMPDIR/gcc4" && sed -i -e "s,../configure --target=ppc-morphos.*$,& MAKEINFO=missing," Makefile) || ERROR=1

	# Older versions of the SDK include a broken Makefile for GCC 4 that fails on parallel builds.

	if grep -q "parallel make works" "$TMPDIR/gcc4/Makefile"
	then
		GCC4MAKEPARALLEL=$MAKEPARALLEL
	else
		GCC4MAKEPARALLEL=""
	fi

	test -z "$ERROR" && (cd "$TMPDIR/gcc4" && make $GCC4MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc4" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 4 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC5" = "y" ]
then
	# Build GCC 5
	echo "Building GCC 5."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' -e 's/--with-plugin-ld=no --enable-languages/--with-plugin-ld=no --disable-sjlj-exceptions --enable-languages/' -e 's/--enable-threads=posix/--enable-threads=morphos/' "$TMPDIR/gcc5/Makefile"
	patch_atomic 5
	patch_gcc_lib_path_fixup 5

	test -z "$ERROR" && (cd "$TMPDIR/gcc5" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc5" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 5 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC6" = "y" ]
then
	# Build GCC 6
	echo "Building GCC 6."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' "$TMPDIR/gcc6/Makefile"
	patch_atomic 6
	patch_gcc_lib_path_fixup 6

	test -z "$ERROR" && (cd "$TMPDIR/gcc6" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc6" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 6 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC7" = "y" ]
then
	# Build GCC 7
	echo "Building GCC 7."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' "$TMPDIR/gcc7/Makefile"
	patch_atomic 7
	patch_gcc_lib_path_fixup 7

	test -z "$ERROR" && (cd "$TMPDIR/gcc7" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc7" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 7 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC8" = "y" ]
then
	# Build GCC 8
	echo "Building GCC 8."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' "$TMPDIR/gcc8/Makefile"
	patch_atomic 8
	patch_gcc_lib_path_fixup 8

	test -z "$ERROR" && (cd "$TMPDIR/gcc8" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc8" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 8 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC9" = "y" ]
then
	# Build GCC 9
	echo "Building GCC 9."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' -e 's/--program-suffix=-8/--program-suffix=-9/g' -e 's/--enable-threads=posix/--enable-threads=morphos/' "$TMPDIR/gcc9/Makefile"
	patch_atomic 9
	patch_gcc_lib_path_fixup 9

	test -z "$ERROR" && (cd "$TMPDIR/gcc9" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc9" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 9 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC10" = "y" ]
then
	# Build GCC 10
	echo "Building GCC 10."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' -e 's/--program-suffix=-8/--program-suffix=-10/g' -e 's/--enable-threads=posix/--enable-threads=morphos/' "$TMPDIR/gcc10/Makefile"
	patch_atomic 10
	patch_gcc_lib_path_fixup 10

	test -z "$ERROR" && (cd "$TMPDIR/gcc10" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc10" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 10 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

if [ "$GCC11" = "y" ]
then
	# Build GCC 11
	echo "Building GCC 11."

	sed -i -e 's/--with-\(mpfr\|gmp\|mpc\)="[^"]*"//g' -e 's/--program-suffix=-8/--program-suffix=-11/g' -e 's/--enable-threads=posix/--enable-threads=morphos/' "$TMPDIR/gcc11/Makefile"
	patch_atomic 11
	patch_makefile_fix_fenv_for_crossbuild 11
	patch_gcc_lib_path_fixup 11

	test -z "$ERROR" && (cd "$TMPDIR/gcc11" && make $MAKEPARALLEL >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1
	test -z "$ERROR" && (cd "$TMPDIR/gcc11" && make install >>"$CURDIR/setup-cross-sdk.log" 2>&1) || ERROR=1

	if [ ! -z "$ERROR" ]
	then
		echo "Failed to build GCC 11 for whatever reason. You're unfortunately on"
		echo "your own now. Check \"$CURDIR/setup-cross-sdk.log\" for details."
		exit 1
	fi
fi

# Set up some GCC symlinks
if [ "$GCC11" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-11 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-11 /gg/bin/ppc-morphos-g++
elif [ "$GCC10" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-10 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-10 /gg/bin/ppc-morphos-g++
elif [ "$GCC9" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-9 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-9 /gg/bin/ppc-morphos-g++
elif [ "$GCC8" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-8 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-8 /gg/bin/ppc-morphos-g++
elif [ "$GCC7" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-7 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-7 /gg/bin/ppc-morphos-g++
elif [ "$GCC6" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-6 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-6 /gg/bin/ppc-morphos-g++
elif [ "$GCC5" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-5 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-5 /gg/bin/ppc-morphos-g++
elif [ "$GCC4" = "y" ]
then
	ln -sf /gg/bin/ppc-morphos-gcc-4 /gg/bin/ppc-morphos-gcc
	ln -sf /gg/bin/ppc-morphos-g++-4 /gg/bin/ppc-morphos-g++
fi

echo 'All done!'

exit 0
