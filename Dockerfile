FROM docker.io/alpine:3.23.2@sha256:c93cec902b6a0c6ef3b5ab7c65ea36beada05ec1205664a4131d9e8ea13e405d

ARG WG_INTERFACE=wgc0
ENV WG_INTERFACE=${WG_INTERFACE}

# renovate: datasource=repology depName=alpine_3_23/iptables
ENV IPTABLES_VERSION="1.8.11-r1"
# renovate: datasource=repology depName=alpine_3_23/sudo
ENV SUDO_VERSION="1.9.17_p2-r0"
# renovate: datasource=repology depName=alpine_3_23/wireguard-tools-wg-quick
ENV WIREGUARD_TOOLS_WG_QUICK_VERSION="1.0.20250521-r1"

RUN apk --no-cache add \
  iptables=${IPTABLES_VERSION} \
  sudo=${SUDO_VERSION} \
  wireguard-tools-wg-quick=${WIREGUARD_TOOLS_WG_QUICK_VERSION}

COPY wg-sudoers /etc/sudoers.d/wg-sudoers

RUN adduser app -h /app -u 1000 -g 1000 -DH
USER 1000
WORKDIR /app
VOLUME /etc/wireguard

COPY run.sh /app/run.sh

ENTRYPOINT /app/run.sh
