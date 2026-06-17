#!/bin/sh
# ==============================================================================
# Home Assistant App (Add-on): Hydris
#
# Container build of Hydris
# ==============================================================================

set -eux

apk add --no-cache ca-certificates nginx tar xz

case "${BUILD_ARCH}" in
"aarch64")
    hydris_arch="arm64"
    ;;
*)
    hydris_arch="${BUILD_ARCH}"
    ;;
esac

hydris_archive="/tmp/hydris.tar.xz"
hydris_release_binary="hydris-cli-linux-${hydris_arch}-${HYDRIS_VERSION}"
hydris_url="https://github.com/projectqai/hydris/releases/download/${HYDRIS_VERSION}/hydris-cli-linux-${hydris_arch}-${HYDRIS_VERSION}.tar.xz"

wget -q -O "${hydris_archive}" "${hydris_url}"
tar -xJf "${hydris_archive}" -C /tmp

if [ ! -f "/tmp/${hydris_release_binary}" ]; then
    echo "Could not find ${hydris_release_binary} in release archive" >&2
    exit 1
fi

install -m 0755 "/tmp/${hydris_release_binary}" /usr/bin/hydris
rm -f "${hydris_archive}"

# Remove legacy cont-init.d services
rm -rf /etc/cont-init.d

# Disable the default nginx site; Hydris ingress is configured explicitly.
rm -f /etc/nginx/http.d/default.conf

# Remove s6 legacy/deprecated and unused services
rm -f /package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/legacy-cont-init
rm -f /package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/fix-attrs
rm -f /package/admin/s6-overlay/etc/s6-rc/sources/top/contents.d/legacy-services
