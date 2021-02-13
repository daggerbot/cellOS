# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = readline readline-devel
PKG_VERSION = 8.1
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/readline/readline-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--disable-static \
	--with-curses
AM_BUILD_ENV = \
	SHLIB_LIBS='-L${SYSROOT}${LIBDIR} -ltinfo'

include ../../mk/pkg.mk
