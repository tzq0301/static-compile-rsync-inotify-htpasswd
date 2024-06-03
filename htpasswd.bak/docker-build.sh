#!/usr/bin/env bash

set -euo pipefail

NAME=static-htpasswd

rm -rf bin/

docker build -t $NAME .

docker rm $NAME || true

docker run --name $NAME $NAME

docker cp $NAME:/build/httpd/static/bin "$PWD"

docker rm $NAME

file bin/htpasswd | grep --color=always -E 'statically|dynamically'

if [[ $(file bin/htpasswd | grep -c statically) -eq 0 ]]; then
  exit 1
fi
