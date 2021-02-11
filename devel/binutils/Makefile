# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = binutils binutils-devel
PKG_VERSION = 2.35
PKG_RELEASE = 1.cellos
PKG_ARCH = x86_64

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/binutils/binutils-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	1b11659fb49e20e18db460d44485f09442c8c56d5df165de9461eb09c8302f85

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--target=${TARGET} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--libexecdir=${LIBEXECDIR} \
	--enable-64-bit-bfd \
	--enable-ld \
	--enable-plugins \
	--enable-shared \
	--disable-bootstrap \
	--disable-werror \
	--with-system-zlib
AM_BUILD_ENV = \
	tooldir=${PREFIX}

include ../../mk/pkg.mk
