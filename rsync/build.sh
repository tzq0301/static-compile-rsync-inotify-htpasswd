#!/usr/bin/env bash

set -e

# sudo apt install -y gcc g++ gawk autoconf automake python3-cmarkgfm
# sudo apt install -y acl libacl1-dev
# sudo apt install -y attr libattr1-dev
# sudo apt install -y libxxhash-dev
# sudo apt install -y libzstd-dev
# sudo apt install -y liblz4-dev
# sudo apt install -y libssl-dev

WORK_DIR=$PWD
RSYNC_DIR=rsync
BUILD_DIR="$WORK_DIR/$RSYNC_DIR/build"

rm -rf $RSYNC_DIR || true

unzip rsync.zip
mv rsync-* $RSYNC_DIR

cd $RSYNC_DIR

./configure --prefix="$BUILD_DIR" CFLAGS='-static'
make -j "$(getconf _NPROCESSORS_CONF)"
make install
