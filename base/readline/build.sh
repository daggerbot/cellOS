# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

majorver="$(printf "%s\n" "$PKG_VERSION" | sed 's/\..*//')"

case $1 in
    stage)
        # Move out readline-devel files
        mkdir -p readline-devel/usr/$LIB readline-devel/usr/share/man
        mv readline/usr/include readline-devel/usr/.
        mv readline/usr/$LIB/*.so readline/usr/$LIB/pkgconfig readline-devel/usr/$LIB/.
        mv readline/usr/share/man/man3 readline-devel/usr/share/man/.

        # Install to /lib (needed by bash)
        mkdir -p readline/$LIB
        mv readline/usr/$LIB/lib*.so.* readline/$LIB/.
        ln -sf ../../$LIB/libhistory.so.$majorver readline-devel/usr/$LIB/libhistory.so
        ln -sf ../../$LIB/libreadline.so.$majorver readline-devel/usr/$LIB/libreadline.so
        ;;
esac
