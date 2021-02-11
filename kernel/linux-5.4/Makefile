# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = kernel-headers
PKG_VERSION = 5.4.94
PKG_RELEASE = 1.cellos
PKG_ARCH = x86_64

DIST_SOURCES = \
	https://cdn.kernel.org/pub/linux/kernel/v$(firstword $(subst ., ,${PKG_VERSION})).x/linux-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	c23df57db7312e9afa5ce477046e227a3c2153efbe1f29045ad23c820aad2b39

include ../../mk/pkg.mk
