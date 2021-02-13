# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Consolidate redundant program names
        for file in binutils/usr/bin/*; do
            name=$(basename $file)
            case $name in
                *-$PKG_VERSION)
                    rm $file
                    ;;
                $TARGET-$TARGET-*)
                    dest=binutils/usr/bin/$(printf "%s\n" "$name" | sed "s/^$TARGET-$TARGET-//")
                    rm -f $dest
                    mv $file $dest
                    ;;
                $TARGET-*)
                    dest=binutils/usr/bin/$(printf "%s\n" "$name" | sed "s/^$TARGET-//")
                    rm -f $dest
                    mv $file $dest
                    ;;
            esac
        done

        for file in binutils/usr/share/man/man1/*; do
            name=$(basename $file)
            case $name in
                $TARGET-*)
                    dest=binutils/usr/share/man/man1/$(printf "%s\n" "$name" | sed "s/^$TARGET-//")
                    rm -f $dest
                    mv $file $dest
                    ;;
            esac
        done

        # Use symlinks instead of hard links
        ln -sf ld.bfd binutils/usr/bin/ld
        mv binutils/usr/share/man/man1/ld.1 binutils/usr/share/man/man1/ld.bfd.1
        ln -sf ld.bfd.1 binutils/usr/share/man/man1/ld.1

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
