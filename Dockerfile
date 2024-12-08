FROM docker.io/alpine:3.21.0@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45

ARG WG_INTERFACE=wgc0
ENV WG_INTERFACE=${WG_INTERFACE}

# renovate: datasource=repology depName=alpine_3_21/iptables
ENV IPTABLES_VERSION="1.8.10-r3"
# renovate: datasource=repology depName=alpine_3_21/sudo
ENV SUDO_VERSION="1.9.15_p5-r0"
# renovate: datasource=repology depName=alpine_3_21/wireguard-tools-wg-quick
ENV WIREGUARD_TOOLS_WG_QUICK_VERSION="1.0.20210914-r4"

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
