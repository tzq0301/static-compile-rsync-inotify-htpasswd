FROM ubuntu

WORKDIR /build

VOLUME /build/httpd/static/bin

COPY . .

RUN apt update && apt install --no-install-recommends -y g++ make autoconf automake libtool libpcre3-dev bzip2 libapr1-dev libaprutil1-dev

RUN sh build.sh
