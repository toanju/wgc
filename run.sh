#!/usr/bin/env bash

set -e

WG_INTERFACE=${WG_INTERFACE:-wgc0}
WG_UP=false

_exit_trap() {
    local exit_code=$?
    echo "Stopping due to exit code ${exit_code}"
    ${WG_UP} && sudo wg-quick down "${WG_INTERFACE}"
}
trap _exit_trap EXIT

sudo wg-quick up ${WG_INTERFACE}
WG_UP=true
sleep infinity &
wait $!
