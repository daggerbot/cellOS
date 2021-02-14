# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

preservedir=/var/lib/ex

case $1 in
    prepare)
        cd "ex-$PKG_VERSION"

        # Change the preserve directory
        sed -i "s@/var/preserve@$preservedir@g" \
            Makefile expreserve.c exrecover.c ex.1 vi.1

        # Increase the maximum terminal size
        sed -E -e 's/^([ \t]*#[ \t]*define[ \t]+TUBELINES)[ \t].*/\1 128/' \
               -e 's/^([ \t]*#[ \t]*define[ \t]+TUBECOLS)[ \t].*/\1 256/' \
               -e 's/^([ \t]*#[ \t]*define[ \t]+TUBESIZE)[ \t].*/\1 (TUBELINES*TUBECOLS)/' \
               -i config.h
        ;;

    build)
        ${MAKE:-make} -C "$SRCDIR/ex-$PKG_VERSION" \
            LDFLAGS="$LDFLAGS -L$SYSROOT/usr/$LIB" \
            LIBEXECDIR=/usr/$LIB \
            PREFIX=/usr \
            TERMLIB=tinfo \
            all
        ;;

    stage)
        ${MAKE:-make} -C "$SRCDIR/ex-$PKG_VERSION" \
            DESTDIR="$STAGEDIR/ex" \
            INSTALL=install \
            LDFLAGS="$LDFLAGS -L$SYSROOT/usr/$LIB" \
            LIBEXECDIR=/usr/$LIB \
            PREFIX=/usr \
            TERMLIB=tinfo \
            install

        # Remove redundant programs
        for file in ex/usr/bin/* ex/usr/share/man/man1/*; do
            case "$(basename $file | sed 's/\.1$//')" in
                ex | vi) ;;
                *) rm $file ;;
            esac
        done

        # Install the preserve directory
        mkdir -p ex/$preservedir
        chmod 1777 ex/$preservedir
        ;;
esac
