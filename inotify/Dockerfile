FROM alpinelinux/build-base

USER root

WORKDIR /build

VOLUME /build/inotify-tools/build/bin

COPY . .

RUN apk add --no-cache unzip bash autoconf automake libtool

RUN sh build.sh
