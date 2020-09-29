FROM alpine:latest

MAINTAINER xx-zhang <actanble@gmail.com>
ENV LANG en_US.UTF-8
WORKDIR /usr/src/app


# 设置alpine的镜像地址为阿里云的地址 3.10->3.9
RUN wget -qO  /get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    echo "https://mirrors.aliyun.com/alpine/v3.9/main/" > /etc/apk/repositories \
        && apk update \
        && apk add tzdata \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && apk add --no-cache bash git curl \
            libxml2-dev  libffi libxml2 libxslt libxslt-dev libjpeg-turbo-dev \
            python3 gcc g++ python3-dev linux-headers libffi-dev openssl-dev \
        && python3 /get-pip.py \
        && cd .. \
        && rm -f /get-pip.py \
        && rm -rf /var/cache/apk/*
# TODO alibevent-dev 没有所以被删除了, NOTE 这里

ADD . /usr/src/app

RUN pip3 install -r /usr/src/app/requirements.txtt

USER root