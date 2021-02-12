# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = gcc gcc-c++ gcc-libs gcc-plugin-devel
PKG_VERSION = 10.2.0
PKG_RELEASE = 1.cellos
PKG_ARCH = any
PKG_OPTIONS = KeepStaticLibs

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/gcc/gcc-${PKG_VERSION}/gcc-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	b8dd4368bb9c7f0b98188317ee0254dd8cc99d1e3a18d0ff146c855fe16c1d8c

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--target=${TARGET} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--libexecdir=${LIBEXECDIR} \
	--enable-languages=c,c++ \
	--disable-bootstrap \
	--disable-multilib \
	--with-system-zlib \
	$(if S{SYSROOT},--with-sysroot='${SYSROOT}')

include ../../mk/pkg.mk
