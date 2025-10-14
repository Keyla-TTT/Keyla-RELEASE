# ---- Builder stage ----
FROM debian:bookworm-slim AS builder
WORKDIR /build
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*
COPY ./release-assets/* ./assets/
COPY ./scripts/* ./scripts/
RUN cd assets && unzip *.zip

# ---- Final runtime stage ----
FROM mongo:6.0
LABEL authors="Valerio Giannini, Marco Frattarola"

WORKDIR /app

RUN mkdir -p /app/assets && mkdir -p /home/keyla/dictionaries && mkdir -p /app/scripts

# Minimal runtime deps only
RUN apt-get update \
  && apt-get install -y --no-install-recommends openjdk-11-jre libcurl4 zlib1g \
  && rm -rf /var/lib/apt/lists/*

# Copy unpacked assets and scripts from builder
COPY --from=builder /build/assets/ /app/assets/
COPY --from=builder /build/scripts/start.sh /app/scripts/start.sh

# Provide keyla CLI in PATH if present
RUN if [ -f /app/assets/keyla-linux ]; then chmod +x /app/assets/keyla-linux && cp /app/assets/keyla-linux /usr/local/bin/keyla; fi

VOLUME /root/keyla/dictionaries
COPY dictionaries/* /root/keyla/dictionaries/

# Make start script executable
RUN chmod +x /app/scripts/start.sh

EXPOSE 9999 27017

VOLUME /data/db

ENTRYPOINT ["/app/scripts/start.sh"]