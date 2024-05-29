#!/usr/bin/env bash

set -euo pipefail

NAME=static-inotify

rm -rf bin/

docker build -t $NAME .

docker run --name $NAME $NAME

docker cp $NAME:/build/inotify-tools/build/bin "$PWD"

docker rm $NAME
