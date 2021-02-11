# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    prepare)
        cd glibc-$PKG_VERSION
        patch -Np1 -i "$CURDIR/glibc-$PKG_VERSION-fhs-1.patch"
        ;;

    stage)
        # Remove unwanted files
        rm -rf glibc/var

        # Move out glibc-common files
        mkdir -p glibc-common/etc glibc-common/usr
        mv glibc/sbin glibc-common/.
        mv glibc/etc/* glibc-common/etc/.
        mv glibc/usr/bin glibc/usr/sbin glibc/usr/share glibc-common/usr/.

        # Move out glibc-devel files
        mkdir -p glibc-devel/usr/$LIB
        mv glibc/usr/include glibc-devel/usr/.

        for file in glibc/usr/$LIB/*; do
            if [ -f $file ]; then
                mv $file glibc-devel/usr/$LIB/.
            fi
        done

        # Move out glibc-static files
        mkdir -p glibc-static/usr/$LIB

        for file in glibc-devel/usr/$LIB/*.a; do
            case $file in
                *_nonshared.a) ;;
                *) mv $file glibc-static/usr/$LIB/.
            esac
        done

        # /etc/ld.so.conf
        mkdir -p glibc-common/etc
        cat >glibc-common/etc/ld.so.conf <<EOF
include /etc/ld.so.conf.d/*.conf
/usr/local/lib
EOF

        # /etc/ld.so.conf.d/libc-$ARCH.conf
        mkdir -p glibc/etc/ld.so.conf.d
        cat >glibc/etc/ld.so.conf.d/libc-$ARCH.conf <<EOF
/$LIB
/usr/$LIB
/usr/local/$LIB
EOF
esac
