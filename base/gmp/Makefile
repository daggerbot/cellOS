# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = gmp gmp-devel
PKG_VERSION = 6.2.1
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/gmp/gmp-${PKG_VERSION}.tar.zst
DIST_SHA256SUMS = \
	8a0c3596c09855450eb67f6e81c5fb6a10babfc4a803d012a877b54c430ea66b

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--disable-cxx \
	--disable-static

include ../../mk/pkg.mk
