FROM docker.io/alpine:3.19.0@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48

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
