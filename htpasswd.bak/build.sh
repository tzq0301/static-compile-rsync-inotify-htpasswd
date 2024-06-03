#!/usr/bin/env bash

set -e

WORK_DIR=$PWD
HTPASSWD_DIR=httpd
BUILD_DIR="$WORK_DIR/$HTPASSWD_DIR/static"

rm -rf $HTPASSWD_DIR || true

# tar -xf httpd-2.4.59.tar.bz2
# mv httpd-2.4.59 $HTPASSWD_DIR

tar -xf 2.4.59.tar.gz
mv httpd-2.4.59 $HTPASSWD_DIR

tar -xf apr-1.7.4.tar.gz -C $HTPASSWD_DIR/srclib
mv $HTPASSWD_DIR/srclib/apr-1.7.4 $HTPASSWD_DIR/srclib/apr

tar -xf apr-util-1.6.3.tar.gz -C $HTPASSWD_DIR/srclib
mv $HTPASSWD_DIR/srclib/apr-util-1.6.3 $HTPASSWD_DIR/srclib/apr-util

tar -xf statifier-1.7.4.tar.gz
cd statifier-1.7.4
make all
make install
cd "$WORK_DIR"

cd "$WORK_DIR/$HTPASSWD_DIR"

./buildconf

./configure --prefix="$BUILD_DIR"

# ./configure --prefix="$BUILD_DIR" --enable-static-support --enable-static-htpasswd
# ./configure --prefix="$BUILD_DIR" --enable-mods-static=all --enable-static-support --enable-static-htpasswd --with-included-apr --enable-modules=all
# ./configure --prefix="$BUILD_DIR" --enable-static-support --enable-static-htpasswd --with-included-apr
# ./configure --prefix="$BUILD_DIR" --enable-static-support --enable-static-htpasswd --with-included-apr --enable-mods-static=all
# ./configure --prefix="$BUILD_DIR" --with-included-apr --enable-mods-static=all --enable-static-support --enable-static-htpasswd --enable-static-htdigest --enable-static-rotatelogs --enable-static-logresolve --enable-static-htdbm --enable-static-ab --enable-static-checkgid --enable-static-htcacheclean --enable-static-httxt2dbm --enable-static-fcgistarter --enable-jansson-staticlib-deps --enable-curl-staticlib-deps
# ./configure --prefix="$BUILD_DIR" --enable-static-support --enable-static-htpasswd --with-included-apr --enable-mods-static=reallyall --enable-modules=reallyall --enable-ssl-staticlib-deps

make clean
./config.nice
make -j "$(getconf _NPROCESSORS_CONF)"
make install

mv "$BUILD_DIR/bin/htpasswd" "$BUILD_DIR/bin/htpasswd-dynamic"

if command -v file >/dev/null 2>&1; then
  file "$BUILD_DIR/bin/htpasswd-dynamic" | grep --color=always -E 'statically|dynamically'
fi

# arch=$(uname -m)
# "$WORK_DIR/ErmineLightTrial.$arch" "$BUILD_DIR/bin/htpasswd-dynamic" --output "$BUILD_DIR/bin/htpasswd"

statifier "$BUILD_DIR/bin/htpasswd-dynamic" "$BUILD_DIR/bin/htpasswd"

if command -v file >/dev/null 2>&1; then
  file "$BUILD_DIR/bin/htpasswd" | grep --color=always -E 'statically|dynamically'
fi
