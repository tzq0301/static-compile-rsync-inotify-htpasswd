#!/usr/bin/env bash

set -e

WORK_DIR=$PWD

APR_TARNAME=apr-1.7.4
APR_DIRNAME=apr
APR_DIR=$WORK_DIR/$APR_DIRNAME

APR_UTIL_TARNAME=apr-util-1.6.3
APR_UTIL_DIRNAME=apr-util
APR_UTIL_DIR=$WORK_DIR/$APR_UTIL_DIRNAME

HTTPD_TARNAME=httpd-2.4.59
HTTPD_DIRNAME=httpd
HTTPD_DIR=$WORK_DIR/$HTTPD_DIRNAME

HTPASSWD_DIR=$WORK_DIR/htpasswd

if [[ -d "$HTPASSWD_DIR" ]]; then
  cp -r "$HTPASSWD_DIR" "$HTPASSWD_DIR.$(date '+%Y%m%d%H%M%S').bak"
fi

rm -rf "$APR_DIR" "$APR_UTIL_DIR" "$HTTPD_DIR" "$HTPASSWD_DIR"

tar -xf "$APR_TARNAME.tar.gz"      && mv "$APR_TARNAME"      "$APR_DIRNAME"
tar -xf "$APR_UTIL_TARNAME.tar.gz" && mv "$APR_UTIL_TARNAME" "$APR_UTIL_DIRNAME"
tar -xf "$HTTPD_TARNAME.tar.gz"    && mv "$HTTPD_TARNAME"    "$HTTPD_DIRNAME"

mkdir -p "$HTPASSWD_DIR"

function build_apr() {
  echo "Building $APR_DIRNAME..."

  cd "$APR_DIR"

  ./buildconf
  ./configure
  make

  cd "$WORK_DIR"
}

function build_apr_util() {
  echo "Building $APR_UTIL_DIRNAME..."

  cd "$APR_UTIL_DIR"

  ./configure --with-apr="$APR_DIR"
  make

  cd "$WORK_DIR"
}

function build_httpd() {
  echo "Building $HTTPD_DIRNAME..."

  cd "$HTTPD_DIR"

  ./buildconf
  ./configure --with-apr="$APR_DIR" --with-apr-util="$APR_UTIL_DIR"
  make

  cd "$WORK_DIR"
}

function copy_file() {
  echo "Copying files..."

  files=(
    "$APR_DIR/include/arch/apr_private_common.h"
    "$APR_DIR/include/arch/unix/apr_private.h"
    "$APR_DIR/misc/unix/charset.c"
    "$APR_DIR/misc/unix/rand.c"
    "$APR_UTIL_DIR/xlate/xlate.c"
    "$HTTPD_DIR/support/htpasswd.c"
    "$HTTPD_DIR/support/passwd_common.c"
    "$HTTPD_DIR/support/passwd_common.h"
  )

  for file in "${files[@]}"; do
    cp "$file" "$HTPASSWD_DIR"
  done

  sed -i '.bak' 's|\.\./||g' "$HTPASSWD_DIR/apr_private.h"
}

build_apr

build_apr_util

build_httpd

copy_file

bash docker-build.sh
