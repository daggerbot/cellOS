# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Use symlinks instead of hard links
        ln -sf ld.bfd binutils/usr/bin/ld

        # Don't install man pages for missing programs
        for man in binutils/usr/share/man/man1/*; do
            name=$(basename $man | sed 's/\.1$//')
            if [ ! -e binutils/usr/bin/$name ]; then
                rm $man
            fi
        done

        # Move out binutils-devel files
        mkdir -p binutils-devel/usr/$LIB binutils-devel/usr/share/info
        mv binutils/usr/include binutils-devel/usr/.
        mv binutils/usr/share/info/bfd.info binutils-devel/usr/share/info/.

        for file in binutils/usr/$LIB/*.so; do
            case $file in
                *-$PKG_VERSION.so) ;;
                *) mv $file binutils-devel/usr/$LIB/. ;;
            esac
        done
        ;;
esac
