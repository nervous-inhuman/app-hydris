FROM ghcr.io/hassio-addons/base:20.2.0

# Set S6 verbosity level
ENV S6_VERBOSITY="1"

# Setup base
ARG BUILD_ARCH="amd64"

# renovate: datasource=github-releases depName=hydris packageName=projectqai/hydris versioning=semver
ARG HYDRIS_VERSION="v0.0.23"

# Copy root filesystem
COPY rootfs /

# Run the script that installs Hydris
RUN ["/build.sh"]

CMD ["/run.sh"]

# Build arguments
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="arisum" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="arisum" \
    org.opencontainers.image.authors="arisum" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${BUILD_REF}" \
    org.opencontainers.image.version="${BUILD_VERSION}"

