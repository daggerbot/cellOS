# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = coreutils
PKG_VERSION = 8.32
PKG_RELEASE = 1.cellos
PKG_ARCH = any

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/coreutils/coreutils-${PKG_VERSION}.tar.xz
DIST_SHA256SUMS = \
	4458d8de7849df44ccab15e16b1548b285224dbba5f08fac070c1c0e0bcc4cfa

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--libexecdir=${LIBEXECDIR} \
	--enable-acl \
	--enable-libcap \
	--enable-xattr \
	--disable-libsmack \
	--disable-rpath \
	--with-gmp="${SYSROOT}${PREFIX}" \
	--without-openssl \
	--without-selinux

include ../../mk/pkg.mk
