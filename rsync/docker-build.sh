#!/usr/bin/env bash

set -euo pipefail

NAME=static-rsync

rm -rf bin/

docker build -t $NAME .

docker run --name $NAME $NAME

docker cp $NAME:/build/rsync/build/bin "$PWD"

docker rm $NAME
