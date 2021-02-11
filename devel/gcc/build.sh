# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Consolidate redundant program names
        for file in gcc/usr/bin/*; do
            name=$(basename $file)
            case $name in
                *-$PKG_VERSION)
                    rm $file
                    ;;
                $TARGET-*)
                    dest=gcc/usr/bin/$(printf "%s\n" "$name" | sed "s/^$TARGET-//")
                    rm $dest
                    mv $file $dest
                    ;;
            esac
        done

        # Install compatibility symlinks
        ln -sf gcc gcc/usr/bin/cc
        ln -sf g++ gcc/usr/bin/c++

        ln -sf gcc.1 gcc/usr/share/man/man1/cc.1
        ln -sf g++.1 gcc/usr/share/man/man1/c++.1

        mkdir -p gcc/lib
        ln -s ../usr/bin/cpp gcc/lib/cpp

        # Move out gcc-libs files
        mkdir -p gcc-libs/usr/$LIB
        mv gcc/usr/$LIB/*.so.* gcc-libs/usr/$LIB/.
        mv gcc-libs/usr/$LIB/*.py gcc/usr/$LIB/.

        # Move out gcc-plugin-devel files
        mkdir -p gcc-plugin-devel/usr/$LIB/gcc/$TARGET/$PKG_VERSION
        mv gcc/usr/$LIB/gcc/$TARGET/$PKG_VERSION/plugin gcc-plugin-devel/usr/$LIB/gcc/$TARGET/$PKG_VERSION/.

        # Install libcc1 to the correct location
        if [ ! $LIB = lib ] && [ -d gcc/usr/lib ]; then
            mv gcc/usr/lib/* gcc/usr/$LIB/.
        fi

        # For some reason, libgcc_s is missing the x permission by default.
        # This is not the case with the other gcc libs.
        chmod a+x gcc-libs/usr/$LIB/libgcc_s.so.*
        ;;
esac
