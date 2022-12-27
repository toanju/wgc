# wireguard-tools container

Wireguard tools in a Alpine Linux container.

## Client example

Update the given `wgclient.conf` to your needs and run

```
podman run --rm -ti -v ./wgclient.conf:/etc/wireguard/client.conf:Z --cap-add NET_ADMIN -e WG_INTERFACE=client ghcr.io/toanju/wgc
```
