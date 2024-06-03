#!/usr/bin/env bash

set -e

WORK_DIR=$PWD

INSTALL_DIR="$WORK_DIR/install"

# --------------------------------------------------------

HTPASSWD_DIRNAME=htpasswd
HTPASSWD_DIR="$WORK_DIR/$HTPASSWD_DIRNAME"

rm -rf "$HTPASSWD_DIR" || true
mkdir "$HTPASSWD_DIR"

HTTPD_DIRNAME=httpd
HTTPD_DIR="$WORK_DIR/$HTTPD_DIRNAME"

rm -rf "$HTTPD_DIR" || true

APR_DIRNAME=apr
APR_DIR="$WORK_DIR/$APR_DIRNAME"

rm -rf "$APR_DIR" || true

APR_UTIL_DIRNAME=apr-util
APR_UTIL_DIR="$WORK_DIR/$APR_UTIL_DIRNAME"

rm -rf "$APR_UTIL_DIR" || true

# --------------------------------------------------------

HTTPD_TAR=httpd-2.4.59

tar -xf "$HTTPD_TAR.tar.gz" && mv "$HTTPD_TAR" "$HTTPD_DIRNAME"

httpd_files=(
  support/htpasswd.c
  support/passwd_common.c
  support/passwd_common.h
)

for file in "${httpd_files[@]}"; do
  cp "$HTTPD_DIR/$file" "$HTPASSWD_DIR/$(basename "$HTTPD_DIR/$file")"
done

# --------------------------------------------------------

APR_TAR=apr-1.7.4

tar -xf "$APR_TAR.tar.gz" && mv "$APR_TAR" "$APR_DIRNAME"

cd "$APR_DIR"

./buildconf
./configure --prefix="$INSTALL_DIR"
make -j "$(getconf _NPROCESSORS_CONF)"
make install

cd "$WORK_DIR"

# --------------------------------------------------------

APR_UTIL_TAR=apr-util-1.6.3

tar -xf "$APR_UTIL_TAR.tar.gz" && mv "$APR_UTIL_TAR" "$APR_UTIL_DIRNAME"

cd "$APR_UTIL_DIR"

./buildconf
./configure --prefix="$INSTALL_DIR" --with-apr="$APR_DIR"
make -j "$(getconf _NPROCESSORS_CONF)"
make install

cd "$WORK_DIR"

# --------------------------------------------------------

cd "$HTTPD_DIR"

./buildconf
./configure --prefix="$INSTALL_DIR" --with-apr="$APR_DIR" --with-apr-util="$APR_UTIL_DIR"
make -j "$(getconf _NPROCESSORS_CONF)"
make install

cd "$WORK_DIR"

# --------------------------------------------------------

cd "$HTPASSWD_DIR"

# gcc -static -Wall -Werror -I"$APR_DIR" -I"$APR_UTIL_DIR"  -I"$HTTPD_DIR" -o htpasswd

# gcc -static -I"$PWD/../install/include" -I"$PWD/../install/include/apr-1" htpasswd.c passwd_common.c -o htpasswd



gcc -static *.c -o htpasswd -I"$PWD/../install/include" -I"$PWD/../install/include/apr-1" -L"$PWD/../install/lib" -lapr-1 -laprutil-1 -lcrypt -luuid
