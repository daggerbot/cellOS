# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    prepare)
        # Apply patches
        cd "bash-$PKG_VERSION"
        for patch in $PATCHES; do
            ${PATCH:-patch} -Np0 -i "$DISTDIR/$patch"
        done

        # Add workarounds for bash's outdated build system relying on hardcoded paths
        sed -Ei "/ac_cv_rl_libdir=/ s@/lib\$@/$LIB@" configure
        ;;

    stage)
        # Remove development files
        # (I'm not even sure what they're for)
        rm -rf bash/usr/include bash/usr/$LIB

        # Install bash as /bin/bash
        mkdir -p bash/bin
        mv bash/usr/bin/bash bash/bin/.

        # Make bashbug use bash instead of /bin/sh
        sed -i 's@/bin/sh@/bin/bash@g' bash/usr/bin/bashbug
        ;;
esac
