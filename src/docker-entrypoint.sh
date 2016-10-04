#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd

if [ "$1" = 'start-daemon' ]; then
    # copy configuration (daemon and plugins)
    cp -ur /etc/emqttd/config/* $EMQTTD_DIR/etc
    cp -ur /etc/emqttd/plugins/* $EMQTTD_DIR/plugins

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
