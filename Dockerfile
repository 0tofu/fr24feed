FROM debian:bookworm-slim AS builder

ARG FR24_VER=1.0.48-0

RUN \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
  set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /fr24feed
RUN set -eux \
  && wget https://repo-feed.flightradar24.com/linux_binaries/fr24feed_${FR24_VER}_amd64.tgz \
  && tar xzvf fr24feed_${FR24_VER}_amd64.tgz --strip-components 1


FROM debian:bookworm-slim

ENV \
  BEASTHOST=readsb \
  BEASTPORT=30005 \
  MLAT=no \
  BIND_INTERFACE='0.0.0.0'

RUN \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
  set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
COPY --from=builder /fr24feed/fr24feed /usr/local/bin/fr24feed
COPY ./init.sh /usr/local/bin/init.sh

EXPOSE 8754

ENTRYPOINT []
CMD ["/usr/local/bin/init.sh"]
