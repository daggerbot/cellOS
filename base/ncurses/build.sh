# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

majorver="$(printf "%s\n" "$PKG_VERSION" | sed 's/\..*//')"

case $1 in
    stage)
        # Move out ncurses-libs files
        mkdir -p ncurses-libs/usr/$LIB
        mv ncurses/usr/$LIB/*.so.* ncurses-libs/usr/$LIB/.

        # Move out ncurses-c++-libs files
        mkdir -p ncurses-c++-libs/usr/$LIB
        mv ncurses-libs/usr/$LIB/*++.so.* ncurses-c++-libs/usr/$LIB/.

        # Move out ncurses-term files
        mkdir -p ncurses-term/usr/share
        mv ncurses/usr/share/tabset ncurses/usr/share/terminfo ncurses-term/usr/share/.

        # Move out ncurses-devel files
        mkdir -p ncurses-devel/usr/bin \
                 ncurses-devel/usr/$LIB \
                 ncurses-devel/usr/share/man
        mv ncurses/usr/bin/ncurses${majorver}-config ncurses-devel/usr/bin/.
        mv ncurses/usr/include ncurses-devel/usr/.
        mv ncurses/usr/$LIB/*.so ncurses/usr/$LIB/pkgconfig ncurses-devel/usr/$LIB/.
        mv ncurses/usr/share/man/man3 ncurses-devel/usr/share/man/.

        # Install libtinfo to /lib (needed by bash)
        mkdir -p ncurses-libs/$LIB
        mv ncurses-libs/usr/$LIB/libtinfo.so.* ncurses-libs/$LIB/.
        ln -sf ../../$LIB/libtinfo.so.$majorver ncurses-devel/usr/$LIB/libtinfo.so
        ;;
esac
