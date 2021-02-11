# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

ifndef __AUTOTOOLS_MK__
__AUTOTOOLS_MK__ := 1

ifndef __PKG_MK__
 $(error pkg.mk must be included from autotools.mk)
endif

#===============================================================================
# Basic autotools variables

# MAINSRCDIR: Nested source directory for the "main" distribution package
ifdef MAINSRCDIR
 MAINSRCDIR := ${SRCDIR}/${MAINSRCDIR}
else
 MAINSRCDIR := ${SRCDIR}/$(firstword ${PKG_NAMES})-${PKG_VERSION}
endif

#===============================================================================
# confhelp: Get help on the autoconf-generated 'configure' script

.PHONY: confhelp

confhelp: ${PREPARE_STAMP}
	cd ${MAINSRCDIR} && ${SH} ./configure --help $(if ${PAGER},| ${PAGER})

#===============================================================================
# configure: Run the autoconf-generated 'configure' script

CONFIGURE := ${MAINSRCDIR}/configure
CONFIGURE_STAMP := ${BUILDDIR}/configure.stamp
CONFIGURE_ENV := ${BUILD_ENV} ${CONFIGURE_ENV}

DEFAULT_CONFIGURE_FLAGS := \
	--host=${HOST} \
	--prefix=${PREFIX} \
	--bindir=${BINDIR} \
	--sbindir=${SBINDIR} \
	--libexecdir=${LIBEXECDIR} \
	--sysconfdir=${SYSCONFDIR} \
	--sharedstatedir=${SHAREDSTATEDIR} \
	--localstatedir=${LOCALSTATEDIR} \
	--runstatedir=${RUNSTATEDIR} \
	--libdir=${LIBDIR} \
	--includedir=${INCLUDEDIR} \
	--datarootdir=${DATAROOTDIR} \
	--datadir=${DATADIR} \
	--infodir=${INFODIR} \
	--localedir=${LOCALEDIR} \
	--mandir=${MANDIR} \
	--docdir=${DOCDIR}

.PHONY: configure configure-again clean-objdir
configure ${BUILD_STAMP}: ${CONFIGURE_STAMP}
configure-again: clean-objdir configure

${CONFIGURE_STAMP}: ${PREPARE_STAMP}
	rm -rf ${OBJDIR} $@ && mkdir -p ${OBJDIR}
	cd ${OBJDIR} && env ${CONFIGURE_ENV} ${SH} '$(abspath ${CONFIGURE})' ${CONFIGURE_FLAGS}
	touch $@

clean-objdir:
	rm -rf ${OBJDIR} ${CONFIGURE_STAMP}

#===============================================================================
# build-hook

build-hook:
	${MAKE} -C ${OBJDIR} ${AM_BUILD_ENV} all

#===============================================================================
# stage-hook

stage-hook:
	${MAKE} -C ${OBJDIR} ${AM_BUILD_ENV} DESTDIR='$(abspath ${STAGEDIR})/$(firstword ${PKG_NAMES})' ${AM_INSTALL_ENV} install

endif # __AUTOTOOLS_MK__
