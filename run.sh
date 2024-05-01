#!/usr/bin/env bash

set -eu

WG_INTERFACE=${WG_INTERFACE:-wgc0}
WG_UP=false
MASQUERADE_INTERFACE="eth+"
MASQUERADE_ENABLED=${MASQUERADE_ENABLED:-true}

_exit_trap() {
    local exit_code=$?
    echo "Stopping due to exit code ${exit_code}"
    if [ "${WG_UP}" = true ]; then
      sudo wg-quick down "${WG_INTERFACE}"
      [ "$MASQUERADE_ENABLED" = true ] && sudo /sbin/iptables -t nat -D POSTROUTING -o "$MASQUERADE_INTERFACE" -j MASQUERADE
    fi
}
trap _exit_trap EXIT

sudo wg-quick up "${WG_INTERFACE}"
WG_UP=true
[ "$MASQUERADE_ENABLED" = true ] && sudo /sbin/iptables -t nat -A POSTROUTING -o "$MASQUERADE_INTERFACE" -j MASQUERADE
sleep infinity &
wait $!
