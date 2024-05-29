FROM ubuntu

WORKDIR /build

VOLUME /build/rsync/build/bin

COPY . .

RUN apt update && apt install --no-install-recommends -y unzip file gcc g++ gawk autoconf make automake python3-cmarkgfm acl libacl1-dev attr libattr1-dev libxxhash-dev libzstd-dev liblz4-dev libssl-dev

RUN sh build.sh
