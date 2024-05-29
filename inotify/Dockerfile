FROM alpine

WORKDIR /build

VOLUME /build/inotify-tools/build/bin

COPY . .

RUN apk add --no-cache g++ make autoconf automake libtool file

RUN sh build.sh
