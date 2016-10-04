#!/bin/bash

# common variables
BUILD_DEPS='wget unzip'
EMQTTD_URL=http://emqtt.io/downloads/stable/debian
ARCHIVE=/opt/temp.zip

# install system dependencies
apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS

# install broker and add it to PATH
wget -O $ARCHIVE "$EMQTTD_URL"; unzip $ARCHIVE -d /opt; rm $ARCHIVE

# cleanup
apt-get purge -y --auto-remove $BUILD_DEPS
rm -rf /var/lib/apt/lists/*
