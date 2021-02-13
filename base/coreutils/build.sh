# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    prepare)
        cd "coreutils-$PKG_VERSION"
        patch -Np1 -i "$CURDIR/coreutils-$PKG_VERSION-i18n-1.patch"
        autoreconf -fiv
        ;;

    stage)
        # Move some programs to /bin per LFS 3.0
        mkdir -p coreutils/bin
        mv coreutils/usr/bin/cat \
           coreutils/usr/bin/chgrp \
           coreutils/usr/bin/chmod \
           coreutils/usr/bin/chown \
           coreutils/usr/bin/cp \
           coreutils/usr/bin/date \
           coreutils/usr/bin/dd \
           coreutils/usr/bin/df \
           coreutils/usr/bin/echo \
           coreutils/usr/bin/false \
           coreutils/usr/bin/kill \
           coreutils/usr/bin/ln \
           coreutils/usr/bin/ls \
           coreutils/usr/bin/mkdir \
           coreutils/usr/bin/mknod \
           coreutils/usr/bin/mv \
           coreutils/usr/bin/pwd \
           coreutils/usr/bin/rm \
           coreutils/usr/bin/rmdir \
           coreutils/usr/bin/sync \
           coreutils/usr/bin/true \
           coreutils/usr/bin/uname \
           coreutils/bin/.

        # Move programs that require root privileges
        mkdir -p coreutils/usr/sbin coreutils/usr/share/man/man8
        for prog in chroot; do
            mv coreutils/usr/bin/$prog coreutils/usr/sbin/.
            mv coreutils/usr/share/man/man1/$prog.1 coreutils/usr/share/man/man8/$prog.8
            sed -i 's/"1"/"8"/' coreutils/usr/share/man/man8/$prog.8
        done
        ;;
esac
