FROM docker.io/alpine:3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

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
