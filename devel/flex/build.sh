# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Move out libfl files
        mkdir -p libfl/usr/$LIB
        mv flex/usr/$LIB/*.so.* libfl/usr/$LIB/.
        ;;
esac
