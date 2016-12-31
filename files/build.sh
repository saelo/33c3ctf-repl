#!/bin/bash

set -e

MUSL=musl-1.1.15
LUA=lua-5.3.3

wget https://www.musl-libc.org/releases/$MUSL.tar.gz
wget https://www.lua.org/ftp/$LUA.tar.gz

tar xzf $MUSL.tar.gz
tar xzf $LUA.tar.gz

pushd $MUSL
patch -p1 < ../musl.patch

CC=clang-3.9
CFLAGS='-fuse-ld=gold -O1 -flto -fsanitize=cfi -fvisibility=hidden -fsanitize-blacklist=../blacklist.txt'
LDFLAGS='-fuse-ld=gold -flto'

CC="${CC}" CFLAGS="${CFLAGS}" ./configure
make
make install
popd

export PATH=/usr/local/musl/bin:$PATH

pushd $LUA
patch -p1 < ../lua.patch
make
cp src/lua ../
popd
