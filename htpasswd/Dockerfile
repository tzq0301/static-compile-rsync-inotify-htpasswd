FROM ubuntu

WORKDIR /build

VOLUME /build/htpasswd/bin

COPY . .

RUN apt update && apt install --no-install-recommends -y gcc apache2-dev libapr1-dev libaprutil1-dev

RUN bash build.sh
