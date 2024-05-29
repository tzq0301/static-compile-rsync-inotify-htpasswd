#!/usr/bin/env bash

set -e

WORK_DIR=$PWD
HTPASSWD_DIR=httpd
BUILD_DIR="$WORK_DIR/$HTPASSWD_DIR/static"

tar -xf httpd-2.4.59.tar.bz2
mv httpd-2.4.59 $HTPASSWD_DIR

tar -xf apr-1.7.4.tar.gz -C $HTPASSWD_DIR/srclib
mv $HTPASSWD_DIR/srclib/apr-1.7.4 $HTPASSWD_DIR/srclib/apr

tar -xf apr-util-1.6.3.tar.gz -C $HTPASSWD_DIR/srclib
mv $HTPASSWD_DIR/srclib/apr-util-1.6.3 $HTPASSWD_DIR/srclib/apr-util

cd $HTPASSWD_DIR

./configure --prefix="$BUILD_DIR" --enable-static-support --enable-static-htpasswd --with-included-apr --enable-modules=all
make -j "$(getconf _NPROCESSORS_CONF)"
make install
