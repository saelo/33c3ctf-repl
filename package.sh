#!/bin/bash

docker exec repl tar czf /tmp/package.tar.gz /lib/ld-musl-x86_64.so.1 /usr/local/musl /home/lua/lua
docker cp repl:/tmp/package.tar.gz .
