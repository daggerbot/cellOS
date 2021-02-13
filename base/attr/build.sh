# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Move out libattr files
        mkdir -p libattr/$LIB
        mv attr/usr/$LIB/libattr.so.* libattr/$LIB/.

        # Move out libattr-devel files
        mkdir -p libattr-devel/usr/share/man
        mv attr/usr/include attr/usr/$LIB libattr-devel/usr/.
        mv attr/usr/share/man/man3 libattr-devel/usr/share/man/.
        ln -sf ../../$LIB/libattr.so.1 libattr-devel/usr/$LIB/libattr.so
        ;;
esac
