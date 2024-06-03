#!/usr/bin/env bash

set -e

WORK_DIR=$PWD
CHRONY_DIR="$WORK_DIR/chrony"
BUILD_DIR="$CHRONY_DIR/build"

tar -xf chrony-4.5.tar.gz
mv chrony-4.5 "$CHRONY_DIR"

cd "$CHRONY_DIR"

LDFLAGS="-static" ./configure --prefix="$BUILD_DIR"
make -j "$(getconf _NPROCESSORS_CONF)"
make install
