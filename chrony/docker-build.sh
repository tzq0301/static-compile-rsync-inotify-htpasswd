#!/usr/bin/env bash

set -euo pipefail

NAME=static-chrony

rm -rf bin/
rm -rf sbin/

docker build -t $NAME .

docker run --name $NAME $NAME

docker cp $NAME:/build/chrony/build/bin "$PWD"
docker cp $NAME:/build/chrony/build/sbin "$PWD"

docker rm $NAME
