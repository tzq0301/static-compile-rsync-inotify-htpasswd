FROM ubuntu

WORKDIR /build

VOLUME /build/inotify-tools/build/bin

COPY . .

RUN apt update && apt install --no-install-recommends -y g++ make autoconf automake libtool file unzip

RUN sh build.sh
