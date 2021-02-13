# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        # Move out libacl files
        mkdir -p libacl/$LIB
        mv acl/usr/$LIB/libacl.so.* libacl/$LIB/.

        # Move out libacl-devel files
        mkdir -p libacl-devel/usr/share/doc/acl \
                 libacl-devel/usr/share/man
        mv acl/usr/include acl/usr/$LIB libacl-devel/usr/.
        mv acl/usr/share/doc/acl/*.txt libacl-devel/usr/share/doc/acl/.
        mv acl/usr/share/man/man3 libacl-devel/usr/share/man/.
        ln -sf ../../$LIB/libacl.so.1 libacl-devel/usr/$LIB/libacl.so
        ;;
esac
