#!/usr/bin/env bash

set -e

WORK_DIR=$PWD
HTPASSWD_SRC="${1:-$WORK_DIR/htpasswd.bak}"
HTPASSWD_DIR="$WORK_DIR/htpasswd"
BIN_DIR="$HTPASSWD_DIR/bin"

rm -rf "$BIN_DIR" || true
mkdir -p "$BIN_DIR"

source_files=(
  "$HTPASSWD_SRC/htpasswd.c"
  "$HTPASSWD_SRC/passwd_common.c"
  "$HTPASSWD_SRC/charset.c"
)

output=htpasswd

gcc -static "${source_files[@]}" -o "$BIN_DIR/$output" -I/usr/include/apr-1.0 -I/usr/include/apache2 "-L/usr/lib/$(uname -m)-linux-gnu" -lapr-1 -laprutil-1 -luuid -lcrypt
