#!/usr/bin/env bash

set -euo pipefail

NAME=static-htpasswd

rm -rf bin/

docker build -t $NAME .

docker run --name $NAME $NAME

docker cp $NAME:/build/htpasswd/bin "$PWD"

docker rm $NAME
