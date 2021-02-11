# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e
printf "Processing package '%s-%s-%s.%s'...\n" "$PKG_NAME" "$PKG_VERSION" "$PKG_RELEASE" "$BUILDARCH" >&2

KeepEmptyDirs=
KeepStaticLibs=

for opt in $PKG_OPTIONS; do
    case $opt in
        KeepEmptyDirs) KeepEmptyDirs=1 ;;
        KeepStaticLibs) KeepStaticLibs=1 ;;
    esac
done

#
# Remove unwanted files
#

printf " * Tidying distribution...\n"

rm -f usr/share/info/dir

for dir in usr/lib*; do
    if [ -d $dir ]; then
        find $dir -type f,l -name '*.la' -delete
    fi
done

if [ ! -n "$KeepEmptyDirs" ]; then
    for dir in $(find . -type d | fgrep / | tac); do
        rmdir --ignore-fail-on-non-empty $dir
    done
fi

if [ ! -n "$KeepStaticLibs" ]; then
    for dir in usr/lib*; do
        if [ -d $dir ]; then
            find $dir -type f -name '*.a' -delete
        fi
    done
fi

#
# Strip binaries
#

stripdirs=

for dir in bin lib* sbin usr/bin usr/lib* usr/sbin; do
    if [ -d $dir ]; then
        stripdirs="$stripdirs $dir"
    fi
done

if [ -n "$stripdirs" ]; then
    printf " * Stripping binaries...\n"

    for dir in $stripdirs; do
        for file in $(find $dir -type f); do
            case $file in
                *.a | *.o) ;;
                *)
                    if ${FILE:-file} -b $file | fgrep 'not stripped' >/dev/null 2>/dev/null; then
                        ${STRIP:-strip} $file
                    fi
                    ;;
            esac
        done
    done
fi

#
# Compress man pages
#

if [ -d usr/share/man ]; then
    printf " * Compressing man pages...\n"

    for file in $(find usr/share/man -type f); do
        case $file in
            *.gz) ;;
            *) gzip $file ;;
        esac
    done

    for file in $(find usr/share/man -type l); do
        case $file in
            *.gz) ;;
            *)
                ln -s $(readlink $file).gz $file.gz
                rm $file
                ;;
        esac
    done
fi

#
# Compress info
#

if [ -d usr/share/info ]; then
    printf " * Compressing info...\n"

    for file in $(find usr/share/info -type f); do
        case $file in
            *.gz) ;;
            *) gzip $file ;;
        esac
    done
fi
