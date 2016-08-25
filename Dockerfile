FROM busybox

# consul
ENV CONSUL=yes \
    CONSUL_ARGS="" \
    CONSUL_BOOTSTRAP_EXPECT=1 \
    CONSUL_DOMAIN=consul \
    CONSUL_DATACENTER=dc1 \
    CONSUL_PORT_DNS=53 \
    CONSUL_RECURSORS="" \
    CONSUL_WAN=""
EXPOSE 53 53/udp 8500 8400 8300 8301 8302
COPY consul /bin/consul
COPY webui /webui

# nomad
ENV NOMAD=yes \
    NOMAD_ARGS="" \
    NOMAD_BOOTSTRAP_EXPECT=1 \
    NOMAD_CLIENT=yes \
    NOMAD_JOIN="" \
    NOMAD_SERVER=yes
COPY nomad /bin/nomad
EXPOSE 4646 4647

COPY init /init
COPY signal /signal
COPY service /service
ENTRYPOINT ["/init"]
