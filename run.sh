#!/usr/bin/env bash

set -e

WG_INTERFACE=${WG_INTERFACE:-wgc0}

_exit_trap() {
    local exit_code=$?
    echo "Stopping due to exit code ${exit_code}"
}
trap _exit_trap EXIT

sudo wg-quick up ${WG_INTERFACE}
sleep infinity &
wait $!
