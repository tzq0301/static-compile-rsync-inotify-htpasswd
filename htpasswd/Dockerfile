FROM ubuntu

WORKDIR /build

VOLUME /build/htpasswd/bin

COPY . .

RUN apt-get update && \
    apt-get install --no-install-recommends -yqq gcc apache2-dev libapr1-dev libaprutil1-dev

RUN bash build.sh
