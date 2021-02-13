# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = attr libattr libattr-devel
PKG_VERSION = 2.4.48
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	http://download.savannah.nongnu.org/releases/attr/attr-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--sysconfdir=${SYSCONFDIR} \
	--disable-static

include ../../mk/pkg.mk
