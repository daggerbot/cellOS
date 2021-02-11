# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Move out zlib-devel files
        mkdir -p zlib-devel/usr/$LIB
        mv zlib/usr/include zlib/usr/share zlib-devel/usr/.
        mv zlib/usr/$LIB/libz.so zlib/usr/$LIB/pkgconfig zlib-devel/usr/$LIB/.
        ;;
esac
