#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd

copy_config() {
    CONFIG_VOLUME=/etc/emqttd/config

    if [ "$(ls -A $CONFIG_VOLUME)" ]; then
        cp -ur $CONFIG_VOLUME/* $EMQTTD_DIR/etc
    fi
}

load_plugins() {
    PLUGINS_LIST=$EMQTTD_DIR/etc/plugins.list
    if [[ -f $PLUGINS_LIST ]]; then
        # wait for daemon to start
        sleep 5

        PLUGINS_VOLUME=/etc/emqttd/plugins
        if [ "$(ls -A $PLUGINS_VOLUME)" ]; then
            cp -ur $PLUGINS_VOLUME/* $EMQTTD_DIR/etc/plugins
        fi

        while IFS= read -r plugin; do
            echo "Loading $plugin..."
            $EMQTTD_DIR/bin/emqttd_ctl plugins load $plugin &
        done < $PLUGINS_LIST
    fi
}

case "$1" in
    "start-daemon")
        copy_config
        load_plugins &
        $EMQTTD_DIR/bin/emqttd-2.0 foreground
        ;;
    *)
        # run any user-provided command
        exec "$@"
esac
