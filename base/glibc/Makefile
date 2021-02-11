# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = glibc glibc-common glibc-devel glibc-static
PKG_VERSION = 2.32
PKG_RELEASE = 1.cellos
PKG_ARCH = x86_64
PKG_OPTIONS = KeepStaticLibs

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/glibc/glibc-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	1627ea54f5a1a8467032563393e0901077626dc66f37f10ee6363bb722222836

BUILD_SYSTEM = autotools
EXCLUDE_CPPFLAGS = -D_FORTIFY_SOURCE=%
EXCLUDE_CFLAGS = -D_FORTIFY_SOURCE=%
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libexecdir=${LIBEXECDIR} \
	--enable-kernel=4.4 \
	--enable-stack-protector=strong \
	--disable-werror \
	--with-headers=${SYSROOT}/usr/include

include ../../mk/pkg.mk
