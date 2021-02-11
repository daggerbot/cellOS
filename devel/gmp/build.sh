# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    prepare)
        # GMP compiles with optimizations for the current machine by default.
        # We need our packages to run on many systems, so we have to tell it to use generic configs.
        cp -f gmp-$PKG_VERSION/configfsf.guess gmp-$PKG_VERSION/config.guess
        cp -f gmp-$PKG_VERSION/configfsf.sub gmp-$PKG_VERSION/config.sub
        ;;

    stage)
        # Move out gmp-devel files
        mkdir -p gmp-devel/usr/$LIB
        mv gmp/usr/include gmp/usr/share gmp-devel/usr/.
        mv gmp/usr/$LIB/pkgconfig gmp/usr/$LIB/*.so gmp-devel/usr/$LIB/.
esac
