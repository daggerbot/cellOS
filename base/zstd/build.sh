# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    build)
        ${MAKE:-make} -C "$SRCDIR/zstd-$PKG_VERSION" VERBOSE=1 default
        ;;

    stage)
        ${MAKE:-make} -C "$SRCDIR/zstd-$PKG_VERSION" VERBOSE=1 \
            prefix="$STAGEDIR/zstd/usr" \
            libdir="$STAGEDIR/zstd/usr/$LIB" \
            install

        # Move out libzstd files
        mkdir -p libzstd/usr/$LIB
        mv zstd/usr/$LIB/libzstd.so.* libzstd/usr/$LIB/.

        # Move out libzstd-devel files
        mkdir -p libzstd-devel/usr
        mv zstd/usr/include zstd/usr/$LIB libzstd-devel/usr/.
        ;;
esac
