FROM alpine:3.19

ARG WG_INTERFACE=wgc0
ENV WG_INTERFACE=${WG_INTERFACE}

RUN apk --no-cache add \
  sudo \
  wireguard-tools-wg-quick

COPY wg-sudoers /etc/sudoers.d/wg-sudoers

RUN adduser app -h /app -u 1000 -g 1000 -DH
USER 1000
WORKDIR /app
VOLUME /etc/wireguard

COPY run.sh /app/run.sh

ENTRYPOINT /app/run.sh
