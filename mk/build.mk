# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

ifndef __BUILD_MK__
__BUILD_MK__ := 1

include $(dir $(lastword ${MAKEFILE_LIST}))common.mk

#===============================================================================
# Get host machine info

# HOST: Target machine for the configured toolchain
CC_MACHINE := $(shell ${CC} -dumpmachine)
CXX_MACHINE := $(shell ${CXX} -dumpmachine)

ifneq ($(words ${CC_MACHINE}),1)
 $(error Unable to determine machine with `${CC} -dumpmachine`)
else ifneq ($(words ${CXX_MACHINE}),1)
 $(error Unable to determine machine with `${CXX} -dumpmachine`)
else ifneq (${CC_MACHINE},${CXX_MACHINE})
 $(error Mismatched machines for `${CC}` and `${CXX}`)
endif

HOST := ${CC_MACHINE}

undefine CC_MACHINE
undefine CXX_MACHINE

# ARCH: Machine architecture that we're building packages for
ARCH :=
ALL_ARCHES := \
	x86_64
x86_64.HOSTS := \
	x86_64-linux-gnu \
	x86_64-pc-linux-gnu \
	x86_64-unknown-linux-gnu

ifdef ARCH
 ifneq ($(words ${ARCH}),1)
  $(error Invalid ARCH: ${ARCH})
 else ifeq ($(filter ${ALL_ARCHES},${ARCH}),)
  $(error Unsupported ARCH: ${ARCH})
 endif
else
 $(foreach arch,${ALL_ARCHES},$(eval ARCH := $$(if $${ARCH},$${ARCH},$$(if $$(filter $${${arch}.HOSTS},$${HOST}),${arch}))))
 ifneq ($(words ${ARCH}),1)
  $(error Unsupported HOST: ${HOST})
 endif
endif

include ${MKINCDIR}/arch/${ARCH}.mk

# ARCHBUILDDIR: Directory containing intermediate files for the current ARCH
ARCHBUILDDIR := ${TOPBUILDDIR}/${ARCH}

# BUILDDIR: Build directory for the current package
BUILDDIR := $(patsubst %/.,%,${ARCHBUILDDIR}/${RELDIR})

#===============================================================================
# Define common installation directories

PREFIX := /usr
LIBDIR := ${PREFIX}/${LIB}
LIBEXECDIR := ${PREFIX}/${LIB}
SYSCONFDIR := $(filter-out /usr,${PREFIX})/etc

# SYSROOT: Directory where dependencies are searched and packages are installed
ifdef SYSROOT
 SYSROOT := $(abspath ${SYSROOT})
 ifneq ($(words ${SYSROOT}),1)
  $(error SYSROOT cannot contain spaces)
 endif
endif

#===============================================================================
# Get final build flags

SYSROOTFLAG := $(if ${SYSROOT},--sysroot=${SYSROOT})
CFLAGS := $(strip $(filter-out ${EXCLUDE_CFLAGS},${CFLAGS} ${SYSROOTFLAG}) ${EXTRA_CFLAGS})
CPPFLAGS := $(strip $(filter-out ${EXCLUDE_CPPFLAGS},${CPPFLAGS} ${SYSROOTFLAG}) ${EXTRA_CPPFLAGS})
CXXFLAGS := $(strip $(filter-out ${EXCLUDE_CXXFLAGS},${CXXFLAGS} ${SYSROOTFLAG}) ${EXTRA_CXXFLAGS})
LDFLAGS := $(strip $(filter-out ${EXCLUDE_LDFLAGS},${LDFLAGS} ${SYSROOTFLAG}) ${EXTRA_LDFLAGS})
LIBS := $(strip $(filter-out ${EXCLUDE_LIBS},${LIBS}) ${EXTRA_LIBS})

BUILD_ENV := \
	CC='${CC}' \
	CFLAGS='${CFLAGS}' \
	CPPFLAGS='${CPPFLAGS}' \
	CXX='${CXX}' \
	CXXFLAGS='${CXXFLAGS}' \
	LDFLAGS='${LDFLAGS}' \
	LIBS='${LIBS}' \
	${BUILD_ENV}

endif # __BUILD_MK__
