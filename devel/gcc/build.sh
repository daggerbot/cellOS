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
                $TARGET-$TARGET-*)
                    dest=gcc/usr/bin/$(printf "%s\n" "$name" | sed "s/^$TARGET-$TARGET-//")
                    rm -f $dest
                    mv $file $dest
                    ;;
                $TARGET-*)
                    dest=gcc/usr/bin/$(printf "%s\n" "$name" | sed "s/^$TARGET-//")
                    rm -f $dest
                    mv $file $dest
                    ;;
            esac
        done

        for file in gcc/usr/share/man/man1/*; do
            name=$(basename $file)
            case $name in
                $TARGET-*)
                    dest=gcc/usr/share/man/man1/$(printf "%s\n" "$name" | sed "s/^$TARGET-//")
                    rm -f $dest
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

        # Move out gcc-c++ files
        mkdir -p gcc-c++/usr/bin \
                 gcc-c++/usr/include \
                 gcc-c++/usr/$LIB \
                 gcc-c++/usr/share/gcc-$PKG_VERSION/python \
                 gcc-c++/usr/share/man/man1
        mv gcc/usr/bin/*++ gcc-c++/usr/bin/.
        mv gcc/usr/include/c++ gcc-c++/usr/include/.
        mv gcc/usr/$LIB/*++*.a \
           gcc/usr/$LIB/*++*.py \
           gcc/usr/$LIB/libstdc++.so \
           gcc-c++/usr/$LIB/.
        mv gcc/usr/share/gcc-$PKG_VERSION/python/libstdcxx gcc-c++/usr/share/gcc-$PKG_VERSION/python/.
        mv gcc/usr/share/man/man1/*++.1 gcc-c++/usr/share/man/man1/.

        # Move out gcc-libs files
        mkdir -p gcc-libs/usr/$LIB
        mv gcc/usr/$LIB/*.so.* gcc-libs/usr/$LIB/.

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
