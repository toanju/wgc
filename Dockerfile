FROM alpine:3.17

RUN apk --no-cache add \
  sudo \
  wireguard-tools-wg \
  wireguard-tools-wg-quick

RUN adduser app -h /app -u 1000 -g 1000 -DH
USER 1000
WORKDIR /app
