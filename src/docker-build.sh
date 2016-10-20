#!/bin/bash

# set user and group first
groupadd -r emqttd && useradd -rm -g emqttd emqttd

# common variables
BUILD_DEPS='wget unzip ca-certificates'
RUNTIME_DEPS='openssl'

# install system dependencies
apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS $RUNTIME_DEPS

# install gosu
GOSU_VERSION=1.7
GOSU_URL="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)"

set -x \
    && wget -O /usr/local/bin/gosu "$GOSU_URL" \
    && wget -O /usr/local/bin/gosu.asc "$GOSU_URL.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

# download and unpack broker
EMQTTD_VERSION="latest"
EMQTTD_URL=http://emqtt.io/downloads/$EMQTTD_VERSION/debian
EMQTTD_ZIP=/opt/emqttd.zip

set -ex \
    && wget -O $EMQTTD_ZIP "$EMQTTD_URL" \
    && unzip $EMQTTD_ZIP -d /opt \
    && rm $EMQTTD_ZIP

# add broker to PATH by symlinking
EMQTTD_BIN=/opt/emqttd/bin
ln -s $EMQTTD_BIN/emqttd /usr/local/bin/emqttd
ln -s $EMQTTD_BIN/emqttd_ctl /usr/local/bin/emqttd_ctl

# cleanup
apt-get purge -y --auto-remove $BUILD_DEPS
rm -rf /var/lib/apt/lists/*
