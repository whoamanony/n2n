FROM alpine:3

ARG VERSION=3.0
WORKDIR /root
RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories          && \
    apk add --no-cache --virtual .build-deps autoconf automake build-base linux-headers             && \
    apk add --no-cache bash iptables tzdata libcap-dev                                              && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime                                             && \
    echo "Asia/Shanghai" > /etc/timezone                                                            && \
    mkdir n2n && cd n2n                                                                             && \
    wget --no-check-certificate -c https://github.com/ntop/n2n/archive/refs/tags/${VERSION}.tar.gz  && \
    tar zxvf ${VERSION}.tar.gz --strip-components=1                                                 && \
    ./autogen.sh                                                                                    && \
    ./configure                                                                                     && \
    make && make install                                                                            && \
    cd .. && rm -rf n2n                                                                             && \
    apk del .build-deps
