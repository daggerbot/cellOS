# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = zlib zlib-devel
PKG_VERSION = 1.2.11
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://www.zlib.net/zlib-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	4ff941449631ace0d4d203e3483be9dbc9da454084111f97ea0a2114e19bf066

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR}

include ../../mk/pkg.mk
