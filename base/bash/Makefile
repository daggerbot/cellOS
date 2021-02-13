# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

PKG_NAMES = bash
PKG_VERSION = 5.1
PKG_RELEASE = ${BASH_PATCHLEVEL}.1.cellos
PKG_ARCH = any

BASH_PATCHLEVEL := 004
BASH_PATCHES := $(addprefix bash$(subst .,,${PKG_VERSION})-,$(shell bash -c 'echo {001..${BASH_PATCHLEVEL}}'))

DIST_SOURCES = \
	https://ftp.gnu.org/gnu/bash/bash-${PKG_VERSION}.tar.gz \
	$(addprefix https://ftp.gnu.org/gnu/bash/bash-${PKG_VERSION}-patches/,${BASH_PATCHES})
DIST_SHA256SUMS = \
	cc012bc860406dcf42f64431bcd3d2fa7560c02915a601aba9cd597a39329baa \
	ebb07b3dbadd98598f078125d0ae0d699295978a5cdaef6282fe19adef45b5fa \
	15ea6121a801e48e658ceee712ea9b88d4ded022046a6147550790caf04f5dbe \
	22f2cc262f056b22966281babf4b0a2f84cb7dd2223422e5dcd013c3dcbab6b1 \
	9aaeb65664ef0d28c0067e47ba5652b518298b3b92d33327d84b98b28d873c86

BUILD_SYSTEM = autotools
CONFIGURE_FLAGS = \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--libdir=${LIBDIR} \
	--with-installed-readline='${SYSROOT}/usr' \
	--without-bash-malloc
BUILD_SH_ENV = \
	PATCHES='${BASH_PATCHES}' \
	SYSROOT='${SYSROOT}'

include ../../mk/pkg.mk
