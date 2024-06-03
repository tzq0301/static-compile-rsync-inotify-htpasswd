# FROM alpine

FROM alpinelinux/build-base

USER root

WORKDIR /build

VOLUME /build/chrony/build/bin
VOLUME /build/chrony/build/sbin

COPY . .

RUN apk add --no-cache bash bison asciidoctor

RUN bash build.sh
