#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd/bin

if [ "$1" = 'start-admin' ]; then
    $EMQTTD_DIR/emqttd_ctl
fi

if [ "$1" = 'start-daemon' ]; then
    $EMQTTD_DIR/emqttd start
    while true; do sleep 100; done
fi

exec "$@"
