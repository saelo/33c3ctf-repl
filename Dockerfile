FROM ubuntu:16.10

RUN apt-get -y update && \
    apt-get -y install wget build-essential xinetd

RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list && \
    echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" >> /etc/apt/sources.list && \
    wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - && \
    apt-get -y update && \
    apt-get -y install clang-3.9

RUN groupadd -g 1000 lua && useradd -g lua -m -u 1000 lua -s /bin/bash

ADD files/ /tmp/files

RUN mv /tmp/files/flag /flag && mv /tmp/files/xinetd.conf /etc/xinetd.d/repl
RUN cd /tmp/files && ./build.sh && mv lua /home/lua/lua && rm -rf /tmp/files

USER lua

CMD xinetd -d -dontfork
