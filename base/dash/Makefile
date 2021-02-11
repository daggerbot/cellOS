# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = dash
PKG_VERSION = 0.5.11.3
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	http://gondor.apana.org.au/~herbert/dash/files/dash-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	62b9f1676ba6a7e8eaec541a39ea037b325253240d1f378c72360baa1cbcbc2a

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--bindir=/bin \
	--enable-static

include ../../mk/pkg.mk
