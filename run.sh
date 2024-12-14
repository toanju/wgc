#!/usr/bin/env bash

set -euE

WG_INTERFACE=${WG_INTERFACE:-wgc0}
WG_UP=false
MASQUERADE_INTERFACE="eth+"
MASQUERADE_ENABLED=${MASQUERADE_ENABLED:-true}
IPTABLES=$(command -v iptables 2>/dev/null)

_exit_trap() {
  local exit_code=$?
  echo "Stopping due to exit code ${exit_code}"
  if [ "${WG_UP}" = true ]; then
    sudo wg-quick down "${WG_INTERFACE}"
    [ "$MASQUERADE_ENABLED" = true ] && sudo "$IPTABLES" -t nat -D POSTROUTING -o "$MASQUERADE_INTERFACE" -j MASQUERADE
  fi
}
trap _exit_trap EXIT

sudo wg-quick up "${WG_INTERFACE}"
WG_UP=true
[ "$MASQUERADE_ENABLED" = true ] && sudo "$IPTABLES" -t nat -A POSTROUTING -o "$MASQUERADE_INTERFACE" -j MASQUERADE
sleep infinity &
wait $!
