#!/bin/sh
set -e

echo "HTTPS: ${HTTPS}"
echo "HOST: ${HOST}"
echo "SPATH: ${SPATH}"
echo "UPDATES: ${UPDATES}"
echo "BACKPORTS: ${BACKPORTS}"
echo "SECURITY: ${SECURITY}"
echo "DEB_SRC: ${DEB_SRC}"
echo "CONTRIB: ${CONTRIB}"
echo "NON_FREE: ${NON_FREE}"
echo "NON_FREE_FIRMWARE: ${NON_FREE_FIRMWARE}"

. /etc/os-release

if [ "${ID}" != "debian" ]; then
    echo "not supported os: ${ID:-unknown}" >&2
    exit 1
fi
if [ -z "$VERSION_CODENAME" ]; then
    echo "not supported version: ${VERSION_CODENAME:-unknown}" >&2
    exit 1
fi

schema="http"
if [ "${HTTPS}" = "true" ]; then
    schema="https"
fi

mirror="${schema}://${host}${spath}"

components="main"
if [ "${CONTRIB}" = "true" ]; then
    components="${components} contrib"
fi
if [ "${NON_FREE}" = "true" ]; then
    components="${components} non-free"
fi
if [ "${NON_FREE_FIRMWARE}" = "true" ]; then
    components="${components} non-free-firmware"
fi

security_host="security.debian.org"
if [ "${SECURITY}" = "true"  ]; then
    security_host="${host}"
fi
security_url="${schema}://${security_host}/debian-security"
security_suite="${VERSION_CODENAME}-security"

rm -rf /etc/apt/sources.list.d/debian.sources
touch -p "/etc/apt/sources.list"

{
    echo "deb ${mirror} ${VERSION_CODENAME} ${components}"
    if [ "${DEB_SRC}" = "true" ]; then
        echo "deb-src ${mirror} ${VERSION_CODENAME} ${components}"
    fi

    if [ "${UPDATES}" = "true" ]; then
        echo "deb ${mirror} ${VERSION_CODENAME}-updates ${components}"
        if [ "${DEB_SRC}" = "true" ]; then
            echo "deb-src ${mirror} ${VERSION_CODENAME}-updates ${components}"
        fi
    fi

    if [ "${BACKPORTS}" = "true" ]; then
        echo "deb ${mirror} ${VERSION_CODENAME}-backports ${components}"
        if [ "${DEB_SRC}" = "true" ]; then
            echo "deb-src ${mirror} ${VERSION_CODENAME}-updates ${components}"
        fi
    fi

    echo "deb ${security_url} ${security_suite} ${components}"
    if [ "${DEB_SRC}" = "true" ]; then
        echo "deb-src ${security_url} ${security_suite} ${components}"
    fi
} > "/etc/apt/sources.list"

echo "Done!"