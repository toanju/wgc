FROM docker.io/alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

ARG WG_INTERFACE=wgc0
ENV WG_INTERFACE=${WG_INTERFACE}

# renovate: datasource=repology depName=alpine_3_22/iptables
ENV IPTABLES_VERSION="1.8.11-r1"
# renovate: datasource=repology depName=alpine_3_22/sudo
ENV SUDO_VERSION="1.9.17_p1-r0"
# renovate: datasource=repology depName=alpine_3_22/wireguard-tools-wg-quick
ENV WIREGUARD_TOOLS_WG_QUICK_VERSION="1.0.20250521-r0"

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
