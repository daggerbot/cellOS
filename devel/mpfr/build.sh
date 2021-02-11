# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Move out mpfr-devel files
        mkdir -p mpfr-devel/usr/$LIB mpfr-devel/usr/share/doc/mpfr
        mv mpfr/usr/include mpfr-devel/usr/.
        mv mpfr/usr/$LIB/pkgconfig mpfr/usr/$LIB/*.so mpfr-devel/usr/$LIB/.
        mv mpfr/usr/share/doc/mpfr/examples mpfr-devel/usr/share/doc/mpfr/.
        mv mpfr/usr/share/info mpfr-devel/usr/share/.
        ;;
esac
