#!/usr/bin/env bash
set -euo pipefail

echo -e "${CCPINK}${CCBOLD}\n---> Compile rust ${CCEND}"

cd /tmp
git clone https://github.com/AmigaLabs/rust.git -b amigaos-port

cd rust
cp amiga/bootstrap.toml.example bootstrap.toml

grep -q '^LOCAL=' amiga/bin/ppc-amigaos-gcc || sed -i '1a\
# Use the local cross toolchain when installed; otherwise run gcc inside the container.\
LOCAL="${AMIGA_GCC:-/opt/ppc-amigaos/bin/ppc-amigaos-gcc}"\
if [ -x "$LOCAL" ]; then\
  exec "$LOCAL" "$@"\
fi' amiga/bin/ppc-amigaos-gcc

export PATH="$PWD/amiga/bin:$PATH"
# The cross toolchain must not leak into host builds: unset these exported variables
unset CC CXX LD AR AS RANLIB

echo -e "${CCPINK}${CCBOLD}\n---> Build rustc ${CCEND}"
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build compiler/rustc

echo -e "${CCPINK}${CCBOLD}\n---> Compile library std ${CCEND}"
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build library/std library/proc_macro library/test --target x86_64-unknown-linux-gnu,powerpc-unknown-amigaos


ROOT="/tmp/rust"
D="/opt/ppc-amigaos/rust"
B="$ROOT/build"

echo -e "${CCPINK}${CCBOLD}\n---> Check build ${CCEND}"
for f in "$B/host/stage1/bin/rustc" "$B/x86_64-unknown-linux-gnu/stage0/bin/cargo" \
         "$B/x86_64-unknown-linux-gnu/stage1/lib/rustlib/powerpc-unknown-amigaos"; do
    [ -e "$f" ] || { echo "missing: $f (build first, see README_AMIGA.md)" >&2; exit 1; }
done

mkdir -p "$D/bin" "$D/lib"

# Binaries: strip all symbols and debug info.
echo -e "${CCPINK}${CCBOLD}\n---> Install rust ${CCEND}"
cp -f "$B/host/stage1/bin/rustc" "$D/bin/rustc"
cp -f "$B/x86_64-unknown-linux-gnu/stage0/bin/cargo" "$D/bin/cargo"
strip "$D/bin/rustc" "$D/bin/cargo"

# Shared libraries: strip debug info only, keep symbols for backtraces.
# -P copies symlinks as symlinks; the .so files are copied as regular files.
cp -aP "$B"/host/stage1/lib/*.so* "$D/lib/"
for so in "$D"/lib/*.so*; do
    # Skip symlinks and linker scripts (e.g. libLLVM-23-*.so holds "INPUT(...)" text).
    if [ ! -L "$so" ] && head -c4 "$so" | grep -q $'\x7fELF'; then
        strip --strip-debug "$so"
    fi
done

# Sysroots (host and AmigaOS). Copied as-is; rlibs are not stripped.
rm -rf "$D/lib/rustlib"
cp -a "$B/x86_64-unknown-linux-gnu/stage1/lib/rustlib" "$D/lib/"

du -sh "$D"
echo "installed to $D"
echo "users: export PATH=$D/bin:/opt/ppc-amigaos/bin:\$PATH"
