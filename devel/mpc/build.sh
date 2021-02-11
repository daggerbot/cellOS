# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Move out libmpc-devel files
        mkdir -p libmpc-devel/usr/$LIB
        mv libmpc/usr/include libmpc/usr/share libmpc-devel/usr/.
        mv libmpc/usr/$LIB/*.so libmpc-devel/usr/$LIB/.
        ;;
esac
