#!/usr/bin/env bash

set -euo pipefail

# sudo apt-get install -y autoconf
# sudo apt-get install -y autotools-dev
# sudo apt-get install -y automake
# sudo apt-get install -y libtool

WORK_DIR=$PWD
INOTIFY_DIR=inotify-tools
BUILD_DIR="$WORK_DIR/$INOTIFY_DIR/build"

unzip inotify-tools.zip
mv inotify-tools-* "$INOTIFY_DIR"

function compile() {
  cd inotify-tools

  ./autogen.sh
  ./configure --prefix="$BUILD_DIR" --enable-all-static
  make -j "$(getconf _NPROCESSORS_CONF)"
  make install

  cd "$WORK_DIR"
}

compile

file "$BUILD_DIR/bin/inotifywait"  | grep --color="always" "statically linked"
file "$BUILD_DIR/bin/inotifywatch" | grep --color="always" "statically linked"
