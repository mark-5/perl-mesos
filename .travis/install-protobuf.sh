#!/bin/sh
set -ex
VERSION=2.6.0

wget https://github.com/google/protobuf/releases/download/v$VERSION/protobuf-$VERSION.tar.gz
tar -zxvf protobuf-$VERSION.tar.gz
cd protobuf-$VERSION && ./configure --prefix=/usr && make && sudo make install
