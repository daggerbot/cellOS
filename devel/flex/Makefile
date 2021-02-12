# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = flex libfl
PKG_VERSION = 2.6.4
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://github.com/westes/flex/files/981163/flex-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR}

include ../../mk/pkg.mk
