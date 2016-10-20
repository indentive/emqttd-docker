#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd

_copy_config() {
    CONFIG_VOLUME=/etc/emqttd/config

    if [ "$(ls -A $CONFIG_VOLUME)" ]; then
        cp -ur $CONFIG_VOLUME/* $EMQTTD_DIR/etc
    fi
}

_load_plugins() {
    PLUGINS_LIST=$EMQTTD_DIR/etc/plugins.list
    if [ -f $PLUGINS_LIST ]; then
        # wait for daemon to start
        sleep 5

        PLUGINS_VOLUME=/etc/emqttd/plugins
        if [ "$(ls -A $PLUGINS_VOLUME)" ]; then
            cp -ur $PLUGINS_VOLUME/* $EMQTTD_DIR/etc/plugins
        fi

        while IFS= read -r plugin; do
            echo "Loading $plugin..."
            emqttd_ctl plugins load $plugin &
        done < $PLUGINS_LIST
    fi
}

if [ "$1" = 'emqttd' -a "$(id -u)" = '0' ]; then
    _copy_config
    _load_plugins &

    chown -R emqttd .
    exec gosu emqttd "$0" "$@"
fi

exec "$@"
