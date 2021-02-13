# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Install dash as /bin/sh
        mv dash/bin/dash dash/bin/sh
        mv dash/usr/share/man/man1/dash.1 dash/usr/share/man/man1/sh.1
        ;;
esac
