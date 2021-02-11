# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

ifndef __COMMON_MK__
__COMMON_MK__ := 1

#===============================================================================
# Define common goals

all:
.PHONY: all clean
.DELETE_ON_ERROR:
.DEFAULT_GOAL := all

#===============================================================================
# Define common paths

# MKINCDIR: Directory containing these build scripts
MKINCDIR := $(patsubst %/,%,$(dir $(lastword ${MAKEFILE_LIST})))

# TOPSRCDIR: Directory containing this source tree
TOPSRCDIR := $(patsubst %/,%,$(dir ${MKINCDIR}))

# DISTDIR: Directory containing downloaded external sources
DISTDIR := ${TOPSRCDIR}/_dist

# TOPBUILDDIR: Directory containing intermediate files
TOPBUILDDIR := ${TOPSRCDIR}/_build

# RPMDIR: Directory containing compiled binary RPMs
RPMDIR := ${TOPSRCDIR}/_rpm

# CURDIR: Directory containing the entry makefile
CURDIR := $(patsubst %/,%,$(dir $(firstword ${MAKEFILE_LIST})))

ifneq ($(abspath ${CURDIR}),$(abspath .))
 $(error Building out of source is not supported)
endif

# RELDIR: CURDIR relative to TOPSRCDIR
_EMPTY :=
_XTOPSRCDIR := $(subst %,@,$(subst ${_EMPTY} ,^,$(abspath ${TOPSRCDIR})))
_XCURDIR := $(subst %,@,$(subst ${_EMPTY} ,^,$(abspath ${CURDIR})))

ifeq (${_XTOPSRCDIR},${_XCURDIR})
 RELDIR := .
else ifeq ($(filter ${_XTOPSRCDIR}/%,${_XCURDIR}),)
 $(error Unable to determine RELDIR)
else
 RELDIR := $(patsubst ${_XTOPSRCDIR}/%,%,${_XCURDIR})
endif

undefine _EMPTY
undefine _XTOPSRCDIR
undefine _XCURDIR

#===============================================================================
# Include user configuration

include ${MKINCDIR}/default.conf

ifdef CONFIG
 ifneq ($(words ${CONFIG}),1)
  $(error Invalid CONFIG '${CONFIG}')
 endif
 include ${CONFIG}
else
 -include ${TOPSRCDIR}/make.conf
endif

endif # __COMMON_MK__
