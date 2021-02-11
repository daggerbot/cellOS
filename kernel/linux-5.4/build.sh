# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $ARCH in
    x86_64) HEADERS_OPTS='ARCH=x86 CONFIG_64BIT=y' ;;
    *) printf "unknown arch: %s\n" "$ARCH" >&2 ; exit 1 ;;
esac

case $1 in
    stage)
        # Install kernel-headers
        make -C "$SRCDIR/linux-$PKG_VERSION" \
            $HEADERS_OPTS \
            INSTALL_HDR_PATH="$STAGEDIR/kernel-headers/usr" \
            headers_install
        ;;
esac
