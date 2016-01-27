nomadconsul
===========

This container provides both nomad and consul in a single container.

Usage
-----
```bash
docker run --rm -it --name nomad \
-v /var/run/docker.sock:/var/run/docker.sock \
--net host \
-e RETRY=1 -e TIMEOUT=1 \
brimstone/nomadconsul
```

`--net host` is needed because nomad tries to map ports to containers based on
the interfaces it finds on the system.

`RETRY=1` Sets the number of times nomad or consul are allowed to try to start

`TIMEOUT=1` Sets the number of seconds between restarts

If the service fails to start after RETRY reaches 0 and TIMEOUT is exhausted,
the entire container exits.

Building
--------

Consul is simply pulled from the official distribution.

Nomad is compiled against musl as the busybox container doesn't contain the same
glibc that the official distribution uses.
