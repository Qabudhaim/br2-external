#!/bin/sh

INTERFACE="$1"
EVENT="$2"

logger "wifi-action: $INTERFACE $EVENT"

case "$EVENT" in

CONNECTED)

    logger "WiFi connected"

    dhcpcd -n "$INTERFACE"

    ;;

DISCONNECTED)

    logger "WiFi disconnected"

    sleep 5

    wpa_cli -i "$INTERFACE" reconnect

    sleep 10

    STATE=$(wpa_cli -i "$INTERFACE" status \
        | awk -F= '/^wpa_state/ {print $2}')

    if [ "$STATE" != "COMPLETED" ]
    then
        logger "Reconnect failed, restarting ESP-Hosted"

        /etc/init.d/S99esp-hosted restart
    fi

    ;;

esac

exit 0
