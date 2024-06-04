#!/usr/bin/env bash

set -e

WORK_DIR=$PWD
HTPASSWD_DIR="${1:-$WORK_DIR/htpasswd.bak}"
BIN_DIR="$HTPASSWD_DIR/bin"

rm -rf "$BIN_DIR" || true
mkdir -p "$BIN_DIR"

source_files=(
  "$HTPASSWD_DIR/htpasswd.c"
  "$HTPASSWD_DIR/passwd_common.c"
  "$HTPASSWD_DIR/charset.c"
)

output=htpasswd

gcc -static "${source_files[@]}" -o "$BIN_DIR/$output" -I/usr/include/apr-1.0 -I/usr/include/apache2 "-L/usr/lib/$(uname -m)-linux-gnu" -lapr-1 -laprutil-1 -luuid -lcrypt
