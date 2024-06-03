FROM ubuntu

WORKDIR /build

COPY . .

RUN apt update && apt install --no-install-recommends -y g++ make autoconf automake libtool libpcre3-dev bzip2 libapr1-dev libaprutil1-dev libtool-bin gcc-multilib python3

RUN bash build.sh
