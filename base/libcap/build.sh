# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

majorver="$(printf "%s\n" "$PKG_VERSION" | sed 's/\..*//')"

case $1 in
    prepare)
        # Don't try to build the PAM module.
        sed -i 's/^PAM_CAP ?=.*/PAM_CAP := no/' "libcap-$PKG_VERSION/Make.Rules"
        ;;

    build)
        ${MAKE:-make} -C "$SRCDIR/libcap-$PKG_VERSION" \
            lib=$LIB \
            all
        ;;

    stage)
        ${MAKE:-make} -C "$SRCDIR/libcap-$PKG_VERSION" \
            lib=$LIB \
            prefix="$STAGEDIR/libcap/usr" \
            install

        # Move runtime libs to /$LIB (needed by coreutils)
        mkdir -p libcap/$LIB
        mv libcap/usr/$LIB/*.so.* libcap/$LIB/.

        # Move out libcap-devel files
        mkdir -p libcap-devel/usr/$LIB libcap-devel/usr/share/man
        mv libcap/usr/include libcap-devel/usr/.
        mv libcap/usr/$LIB/*.so libcap/usr/$LIB/pkgconfig libcap-devel/usr/$LIB
        mv libcap/usr/share/man/man3 libcap-devel/usr/share/man/.
        ln -sf ../../$LIB/libcap.so.$majorver libcap-devel/usr/$LIB/libcap.so
        ln -sf ../../$LIB/libpsx.so.$majorver libcap-devel/usr/$LIB/libpsx.so

        # Move out libcap-bin files
        mkdir -p libcap-bin/usr/bin
        mv libcap/usr/sbin/capsh libcap-bin/usr/bin/.
        mv libcap/usr/sbin libcap/usr/share libcap-bin/usr/.

        # Make libs executable so rpmbuild can handle them
        chmod a+x libcap/$LIB/*.so.$PKG_VERSION
        ;;
esac
