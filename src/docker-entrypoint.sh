#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd

if [ "$1" = 'start-daemon' ]; then
    #
    # Copy user-provided configuration
    #
    CONFIG_VOLUME=/etc/emqttd/config
    if [ "$(ls -A $CONFIG_VOLUME)" ]; then
        cp -ur $CONFIG_VOLUME/* $EMQTTD_DIR/etc
    fi

    #
    # Start EMQTT daemon
    #
    $EMQTTD_DIR/bin/emqttd start

    #
    # Load the plugins if the plugins list is provided
    #
    PLUGINS_LIST=$EMQTTD_DIR/etc/plugins.list
    if [[ -f $PLUGINS_LIST ]]; then
        PLUGINS_VOLUME=/etc/emqttd/plugins
        if [ "$(ls -A $PLUGINS_VOLUME)" ]; then
            cp -ur $PLUGINS_VOLUME/* $EMQTTD_DIR/plugins
        fi

        while IFS= read -r plugin; do
            echo "Loading $plugin..."
            $EMQTTD_DIR/bin/emqttd_ctl plugins load $plugin &
        done < $PLUGINS_LIST
    fi

    #
    # Due to the fact that EMQTT can be started only as daemon, an infinite
    # loop must be added to prevent container from early termination.
    #
    while true; do sleep 100; done
fi

#
# Run any user-provided command
#
exec "$@"
