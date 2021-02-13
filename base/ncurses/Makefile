# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = \
	ncurses \
	ncurses-c++-libs \
	ncurses-devel \
	ncurses-libs \
	ncurses-term
PKG_VERSION = 6.2
PKG_RELEASE = 1.cellos
PKG_ARCH = any

ncurses-term.PKG_ARCH = noarch

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/ncurses/ncurses-${PKG_VERSION}.tar.gz
DIST_SHA256SUMS = \
	30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--enable-pc-files \
	--enable-symlinks \
	--with-cxx \
	--with-cxx-binding \
	--with-cxx-shared \
	--with-fallbacks=dumb,linux \
	--with-manpage-symlinks \
	--with-pkg-config-libdir=${LIBDIR}/pkgconfig \
	--with-shared \
	--with-termlib \
	--with-ticlib \
	--without-ada \
	--without-debug \
	--without-normal

include ../../mk/pkg.mk
