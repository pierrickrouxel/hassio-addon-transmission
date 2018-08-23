ARG BUILD_FROM=hassioaddons/base:2.1.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY rootfs /

# Setup base
RUN apk add --no-cache \
    coreutils=8.29-r2 \
    transmission-daemon

# Scrip to run after startup
CMD ["/usr/bin/run.sh"]

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Transmission" \
    io.hass.description="The torrent client for Hass.io" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Pierrick Rouxel <pierrickrouxel@addons.community>" \
    org.label-schema.description="The torrent client for Hass.io" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Transmission" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/pierrickrouxel" \
    org.label-schema.usage="https://github.com/pierrickrouxel/hassio-addon-transmission/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/pierrickrouxel" \
    org.label-schema.vendor="Community Hass.io Addons"
