# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

set -e

case $1 in
    stage)
        cd filesystem

        mkdir -p bin \
                 boot \
                 dev \
                 etc/opt \
                 home \
                 lib \
                 $LIB \
                 media \
                 mnt \
                 opt \
                 proc \
                 root \
                 run \
                 sbin \
                 srv \
                 sys \
                 tmp \
                 usr/bin \
                 usr/games \
                 usr/include \
                 usr/lib \
                 usr/$LIB \
                 usr/local/bin \
                 usr/local/etc \
                 usr/local/games \
                 usr/local/include \
                 usr/local/lib \
                 usr/local/$LIB \
                 usr/local/sbin \
                 usr/local/share/doc \
                 usr/local/share/games \
                 usr/local/share/info \
                 usr/local/share/locale \
                 usr/local/share/man \
                 usr/local/share/misc \
                 usr/local/src \
                 usr/sbin \
                 usr/share/doc \
                 usr/share/games \
                 usr/share/info \
                 usr/share/locale \
                 usr/share/man \
                 usr/share/misc \
                 usr/src \
                 var/cache \
                 var/crash \
                 var/games \
                 var/lib/misc \
                 var/lock \
                 var/log \
                 var/mail \
                 var/opt \
                 var/spool/cron \
                 var/tmp

        ln -s share/man usr/local/man
        ln -s ../run var/run
        ;;
esac
