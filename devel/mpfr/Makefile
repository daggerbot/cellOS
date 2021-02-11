# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = mpfr mpfr-devel
PKG_VERSION = 4.1.0
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/mpfr/mpfr-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--enable-thread-safe \
	--disable-static

include ../../mk/pkg.mk
