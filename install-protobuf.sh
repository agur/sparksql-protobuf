#!/bin/sh

set -ex

PROTOBUF_VERSION_DEFAULT=2.6.1
[ "$PROTOBUF_VERSION" ] || {
    echo PROTOBUF_VERSION env var is undefined, using the current \(9/2015\) latest released $PROTOBUF_VERSION_DEFAULT as default.
    PROTOBUF_VERSION=2.6.1
}

case "$PROTOBUF_VERSION" in
    2*) basename=protobuf-$PROTOBUF_VERSION ;;
    3*) basename=protobuf-cpp-$PROTOBUF_VERSION ;;
     *) die "unknown protobuf version: $PROTOBUF_VERSION" ;;
esac

curl -sL https://github.com/google/protobuf/releases/download/v$PROTOBUF_VERSION/$basename.tar.gz | tar zx
cd protobuf-$PROTOBUF_VERSION
# TODO: Review - was /home/travis.  /Users/ is used for home dirs on a mac, and trying user space to avoid sudoing.
dir=~/travis
mkdir -p $dir
./configure --prefix=$dir && make -j2 && make install