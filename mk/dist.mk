# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

ifndef __DIST_MK__
__DIST_MK__ := 1

ifndef __PKG_MK__
 $(error dist.mk must be included from pkg.mk)
endif

#===============================================================================
# Basic external source variables

# Check required variables
ifeq ($(words ${DIST_SOURCES}),0)
 $(error Missing DIST_SOURCES)
else ifneq ($(words ${DIST_SOURCES}),$(words ${DIST_SHA256SUMS}))
 $(error Wrong number of DIST_SHA256SUMS)
endif

# DIST_FILENAMES: DIST_SOURCES without the full URL
DIST_FILENAMES := $(notdir ${DIST_SOURCES})

ifneq ($(words ${DIST_FILENAMES}),$(words $(sort ${DIST_FILENAMES})))
 $(error Duplicate base names in DIST_SOURCES)
endif

# DIST_FILES: Downloaded source paths
DIST_FILES := $(addprefix ${DISTDIR}/,${DIST_FILENAMES})

# DIST_INDICES: Indices into DIST_SOURCES and friends
DIST_INDICES :=
$(foreach src,${DIST_SOURCES},$(eval DIST_INDICES := $${DIST_INDICES} $$(words $${DIST_INDICES} +1)))

# DIST_TARBALLS: Sources to be extracted with ${TAR}
DIST_TARBALLS := $(filter %.tar %.tar.bz2 %.tar.gz %.tar.xz %.tar.zst %.tgz %.txz,${DIST_FILES})

# DIST_NOEXTRACT: Sources that are left unchanged
DIST_NOEXTRACT := $(filter-out ${DIST_TARBALLS},${DIST_FILES})

#===============================================================================
# fetch: Download external sources

.PHONY: fetch fetch-again clean-distfiles
fetch: ${DIST_FILES}
fetch-again: clean-distfiles fetch

${DIST_FILES}:
	mkdir -p $(dir $@)
	cd $(dir $@) && ${WGET} "$(strip $(foreach i,${DIST_INDICES},$(if $(filter $(word $i,${DIST_FILENAMES}),$(notdir $@)),$(word $i,${DIST_SOURCES}))))"

clean-distfiles:
	rm -f ${DIST_FILES}

#===============================================================================
# cksum: Print SHA-256 sums of downloaded sources

.PHONY: cksum

cksum: ${DIST_FILES}
	cd ${DISTDIR} && ${SHA256SUM} ${DIST_FILENAMES}

#===============================================================================
# prepare: Extract and patch external sources

PREPARE_STAMP := ${BUILDDIR}/prepare.stamp
SUMFILE := ${BUILDDIR}/sha256sums

.PHONY: prepare do-prepare prepare-again clean-srcdir
prepare: ${PREPARE_STAMP}
prepare-again: clean-srcdir prepare

${PREPARE_STAMP}: ${DIST_FILES}
	rm -rf ${SRCDIR} $@ ${SUMFILE} && mkdir -p ${SRCDIR}
	: $(foreach i,${DIST_INDICES},&& echo '$(word $i,${DIST_SHA256SUMS})  $(word $i,${DIST_FILENAMES})' >> ${SUMFILE})
	cd ${DISTDIR} && cat '$(abspath ${SUMFILE})' | ${SHA256SUM} -c -
ifneq ($(words ${DIST_TARBALLS}),0)
	: $(foreach file,${DIST_TARBALLS},&& tar -xf ${file} -C ${SRCDIR})
endif
	${MAKE} --no-print-directory do-prepare
ifneq ($(wildcard build.sh),)
	cd ${SRCDIR} && env \
		ARCH='${ARCH}' \
		CURDIR='$(abspath ${CURDIR})' \
		DISTDIR='$(abspath ${DISTDIR})' \
		PKG_VERSION='${PKG_VERSION}' \
		SRCDIR='$(abspath ${SRCDIR})' \
		${BUILD_SH_ENV} \
		${SH} '$(abspath build.sh)' prepare
endif
	touch $@

clean-srcdir:
	rm -rf ${SRCDIR} ${PREPARE_STAMP}

endif # __DIST_MK__
