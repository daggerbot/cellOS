# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

ifndef __PKG_MK__
__PKG_MK__ := 1

include $(dir $(lastword ${MAKEFILE_LIST}))build.mk

#===============================================================================
# Basic package variables

# Check required variables
ifeq ($(words ${PKG_NAMES}),0)
 $(error Missing PKG_NAMES)
endif

# Derive subpackage variables
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.PKG_VERSION ?= $${PKG_VERSION}))
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.PKG_RELEASE ?= $${PKG_RELEASE}))
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.PKG_ARCH ?= $${PKG_ARCH}))
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.PKG_OPTIONS ?= $${PKG_OPTIONS}))
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.BUILDARCH := $$(if $$(filter any,$${${pkg}.PKG_ARCH}),$${ARCH},$$(filter noarch $${ARCH},$${${pkg}.PKG_ARCH}))))

# Check subpackage variables
$(foreach pkg,${PKG_NAMES},$(if $(filter 1,$(words ${${pkg}.PKG_VERSION})),,$(error Missing or invalid ${pkg}.PKG_VERSION)))
$(foreach pkg,${PKG_NAMES},$(if $(filter 1,$(words ${${pkg}.PKG_RELEASE})),,$(error Missing or invalid ${pkg}.PKG_RELEASE)))
$(foreach pkg,${PKG_NAMES},$(if $(filter %.cellos,${${pkg}.PKG_RELEASE}),,$(error ${pkg}.PKG_RELEASE must end with .cellos)))
$(foreach pkg,${PKG_NAMES},$(if $(filter 0,$(words ${${pkg}.PKG_ARCH})),$(error Missing ${pkg}.PKG_ARCH)))
$(foreach pkg,${PKG_NAMES},$(if $(filter 0,$(words ${${pkg}.BUILDARCH})),$(error ${pkg} does not support ${ARCH})))
$(foreach pkg,${PKG_NAMES},$(if $(filter 1,$(words ${${pkg}.BUILDARCH})),,$(error Invalid ${pkg}.PKG_ARCH)))

# SRCDIR: Optional nested source directory
SRCDIR := ${BUILDDIR}/src

# OBJDIR: Optional nested object directory
OBJDIR := ${BUILDDIR}/obj

#===============================================================================
# Download external sources

ifneq ($(words ${DIST_SOURCES}),0)
 include ${MKINCDIR}/dist.mk
endif

#===============================================================================
# build: Build package sources

BUILD_STAMP := ${BUILDDIR}/build.stamp

.PHONY: build build-hook build-again clean-build-stamp
build: ${BUILD_STAMP}
build-again: clean-build-stamp build

${BUILD_STAMP}: ${PREPARE_STAMP}
	rm -f ${BUILD_STAMP} && mkdir -p ${OBJDIR}
	${MAKE} --no-print-directory $(if ${CONFIG},CONFIG='${CONFIG}') build-hook
ifneq ($(wildcard build.sh),)
	cd ${OBJDIR} && env \
		ARCH='${ARCH}' \
		PKG_VERSION='${PKG_VERSION}' \
		${BUILD_SH_ENV} \
		${SH} '$(abspath build.sh)' build
endif
	touch $@

#===============================================================================
# stage: Install the package files to a temporary location for further processing

STAGEDIR := ${BUILDDIR}/stage
STAGE_STAMP := ${BUILDDIR}/stage.stamp

.PHONY: stage stage-hook stage-again clean-stagedir
all stage: ${STAGE_STAMP}
stage-again: clean-stagedir stage

${STAGE_STAMP}: ${BUILD_STAMP}
	rm -rf ${STAGEDIR} ${STAGE_STAMP} && mkdir -p $(addprefix ${STAGEDIR}/,${PKG_NAMES})
	${MAKE} --no-print-directory $(if ${CONFIG},CONFIG='${CONFIG}') stage-hook
ifneq ($(wildcard build.sh),)
	cd ${STAGEDIR} && env \
		ARCH='${ARCH}' \
		CURDIR='$(abspath ${CURDIR})' \
		LIB='${LIB}' \
		OBJDIR='$(abspath ${OBJDIR})' \
		PKG_VERSION='${PKG_VERSION}' \
		SRCDIR='$(abspath ${SRCDIR})' \
		STAGEDIR='$(abspath ${STAGEDIR})' \
		TARGET='${TARGET}' \
		${BUILD_SH_ENV} \
		${SH} '$(abspath build.sh)' stage
endif
	: $(foreach pkg,${PKG_NAMES},&& cd '$(abspath ${STAGEDIR})/${pkg}' && env \
		BUILDARCH='${${pkg}.BUILDARCH}' \
		PKG_NAME='${pkg}' \
		PKG_OPTIONS='${${pkg}.PKG_OPTIONS}' \
		PKG_RELEASE='${${pkg}.PKG_RELEASE}' \
		PKG_VERSION='${${pkg}.PKG_VERSION}' \
		${SH} '$(abspath ${MKINCDIR})/post-stage.sh')
	touch $@

clean-stagedir:
	rm -rf ${STAGEDIR} ${STAGE_STAMP}

#===============================================================================
# ls-files: List staged files

.PHONY: ls-files

ls-files: ${STAGE_STAMP}
	cd ${STAGEDIR} && find * | fgrep / | sort | $(if ${FAKEROOT},${FAKEROOT} --) xargs -- stat -c '%A %u %g %N' | sed -E 's/^(.).*;/\1/' $(if ${PAGER},| ${PAGER})

#===============================================================================
# clean: Clean the package's entire intermediate directory

clean:
	rm -rf ${BUILDDIR}

#===============================================================================
# Include common build systems

ifeq (${BUILD_SYSTEM},)
else ifeq (${BUILD_SYSTEM},autotools)
 include ${MKINCDIR}/autotools.mk
else
 $(error Invalid BUILD_SYSTEM '${BUILD_SYSTEM}')
endif

#===============================================================================
# Build RPM packages

include ${MKINCDIR}/rpm.mk

endif # __PKG_MK__
