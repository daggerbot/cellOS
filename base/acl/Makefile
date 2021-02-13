# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = acl libacl libacl-devel
PKG_VERSION = 2.2.53
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	http://download.savannah.nongnu.org/releases/acl/acl-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	06be9865c6f418d851ff4494e12406568353b891ffe1f596b34693c387af26c7

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--libexecdir=${LIBEXECDIR} \
	--disable-static

include ../../mk/pkg.mk
