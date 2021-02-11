# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = libmpc libmpc-devel
PKG_VERSION = 1.2.1
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/mpc/mpc-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459

BUILD_SYSTEM = autotools
MAINSRCDIR = mpc-${PKG_VERSION}
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--disable-static

include ../../mk/pkg.mk
