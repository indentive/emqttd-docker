#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd

if [ "$1" = 'start-daemon' ]; then
    # copy daemon configuration
    CONFIG_VOLUME=/etc/emqttd/config
    if [ "$(ls -A $CONFIG_VOLUME)" ]; then
        cp -ur $CONFIG_VOLUME/* $EMQTTD_DIR/etc
    fi

    # copy plugins configuration
    PLUGINS_VOLUME=/etc/emqttd/plugins
    if [ "$(ls -A $PLUGINS_VOLUME)" ]; then
        cp -ur $PLUGINS_VOLUME/* $EMQTTD_DIR/plugins
    fi

    # start daemon
    $EMQTTD_DIR/bin/emqttd start

    # autoload plugins
    cd $EMQTTD_DIR/plugins
    for plugin in * ; do
        echo $plugin
        $EMQTTD_DIR/bin/emqttd_ctl plugins load $plugin
    done

    # wait
    while true; do sleep 100; done
fi

exec "$@"
