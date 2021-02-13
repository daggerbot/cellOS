# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

printf "%%define _build_id_links none\n"
printf "\n"
printf "Name: %s\n" "$PKG_NAME"
printf "Version: %s\n" "$PKG_VERSION"
printf "Release: %s\n" "$PKG_RELEASE"
printf "BuildArch: %s\n" "$BUILDARCH"

cat "$CURDIR/$PKG_NAME.spec"

printf "\n"
printf "%%files\n"

for file in $(find . | fgrep / | sed 's@^\./@@' | sort); do
    if [ -d $file ] && [ ! -L $file ]; then
        printf "%%dir "
    else
        case $file in
            etc/*) printf "%%config " ;;
            usr/share/doc/*) printf "%%doc " ;;
        esac
    fi

    printf "/%s\n" "$file"
done
