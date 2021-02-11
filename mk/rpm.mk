# Copyright (c) 2021 Marty Mills <daggerbot@gmail.com>
# This file is subject to the terms of the ISC license.
# See LICENSE.txt in the project directory for more information.

ifndef __RPM_MK__
__RPM_MK__ := 1

ifndef __PKG_MK__
 $(error rpm.mk must be included from pkg.mk)
endif

#===============================================================================
# Basic RPM variables

# Derive per-package variables
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.RPMNAME := ${pkg}-$${${pkg}.PKG_VERSION}-$${${pkg}.PKG_RELEASE}.$${${pkg}.BUILDARCH}))
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.RPM := $${RPMDIR}/$${${pkg}.BUILDARCH}/$${${pkg}.RPMNAME}.rpm))
$(foreach pkg,${PKG_NAMES},$(eval ${pkg}.SPECFILE := $${BUILDDIR}/${pkg}.spec))

#===============================================================================
# spec: Generate full spec files for each subpackage

.PHONY: spec spec-again clean-spec
.PHONY: $(foreach pkg,${PKG_NAMES},$(addsuffix @${pkg},spec spec-again clean-spec))
spec: $(addprefix spec@,${PKG_NAMES})
spec-again: $(addprefix spec-again@,${PKG_NAMES})
clean-spec: $(addprefix clean-spec@,${PKG_NAMES})
$(foreach pkg,${PKG_NAMES},$(eval spec@${pkg}: $${${pkg}.SPECFILE}))
$(foreach pkg,${PKG_NAMES},$(eval spec-again@${pkg}: clean-spec@${pkg} spec@${pkg}))
$(foreach pkg,${PKG_NAMES},$(eval clean-spec@${pkg} $${${pkg}.SPECFILE}: PKG_NAME=${pkg}))

$(foreach pkg,${PKG_NAMES},${${pkg}.SPECFILE}): ${STAGE_STAMP}
	rm -f ${${PKG_NAME}.SPECFILE}
	cd ${STAGEDIR}/${PKG_NAME} && env \
		BUILDARCH='${${PKG_NAME}.BUILDARCH}' \
		CURDIR='$(abspath ${CURDIR})' \
		PKG_NAME='${PKG_NAME}' \
		PKG_RELEASE='${${PKG_NAME}.PKG_RELEASE}' \
		PKG_VERSION='${${PKG_NAME}.PKG_VERSION}' \
		${SH} '$(abspath ${MKINCDIR})/genspec.sh' > '$(abspath $@)'

$(addprefix clean-spec@,${PKG_NAMES}):
	rm -f ${${PKG_NAME}.SPECFILE}

#===============================================================================
# show-spec@<pkg>: Print contents of the spec file

.PHONY: $(addprefix show-spec@,${PKG_NAMES})
$(foreach pkg,${PKG_NAMES},$(eval show-spec@${pkg}: $${${pkg}.SPECFILE}))
$(foreach pkg,${PKG_NAMES},$(eval show-spec@${pkg}: PKG_NAME=${pkg}))

$(addprefix show-spec@,${PKG_NAMES}):
	cat ${${PKG_NAME}.SPECFILE} $(if ${PAGER},| ${PAGER})

#===============================================================================
# rpm: Build binary RPM packages

.PHONY: rpm rpm-again clean-rpm
.PHONY: $(foreach pkg,${PKG_NAMES},$(addsuffix @${pkg},rpm rpm-again clean-rpm))
all rpm: $(addprefix rpm@,${PKG_NAMES})
rpm-again: $(addprefix rpm-again@,${PKG_NAMES})
clean-rpm: $(addprefix clean-rpm@,${PKG_NAMES})
$(foreach pkg,${PKG_NAMES},$(eval rpm@${pkg}: $${${pkg}.RPM}))
$(foreach pkg,${PKG_NAMES},$(eval rpm-again@${pkg}: clean-rpm@${pkg} rpm@${pkg}))
$(foreach pkg,${PKG_NAMES},$(eval clean-rpm@${pkg} $${${pkg}.RPM}: PKG_NAME=${pkg}))
$(foreach pkg,${PKG_NAMES},$(eval $${${pkg}.RPM}: $${${pkg}.SPECFILE}))

$(foreach pkg,${PKG_NAMES},${${pkg}.RPM}):
	rm -f $@ && mkdir -p $(dir $@)
	$(if ${FAKEROOT},${FAKEROOT} --) ${RPMBUILD} -bb \
		--buildroot '$(abspath ${STAGEDIR})/${PKG_NAME}' \
		--target ${HOST} \
		--noclean \
		--define '_topdir $(abspath ${BUILDDIR})' \
		--define '_rpmdir $(abspath ${RPMDIR})' \
		--define '_deparch $(subst _,-,${ARCH})' \
		${${PKG_NAME}.SPECFILE}

$(addprefix clean-rpm@,${PKG_NAMES}):
	rm -f ${${PKG_NAME}.RPM}

#===============================================================================
# install: Install built binary RPMs

.PHONY: install $(addprefix install@,${PKG_NAMES})
$(foreach pkg,${PKG_NAMES},$(eval install@${pkg}: $${${pkg}.RPM}))
$(foreach pkg,${PKG_NAMES},$(eval install@${pkg}: PKG_NAME=${pkg}))

install:
	${RPM} -U \
		$(if ${SYSROOT},--root '${SYSROOT}') \
		--oldpackage \
		--replacepkgs \
		$(foreach pkg,${PKG_NAMES},${${pkg}.RPM})

$(addprefix install@,${PKG_NAMES}):
	${RPM} -U \
		$(if ${SYSROOT},--root '${SYSROOT}') \
		--oldpackage \
		--replacepkgs \
		${${PKG_NAME}.RPM}

#===============================================================================
# uninstall: Uninstall built or existing RPMs

.PHONY: uninstall $(addprefix uninstall@,${PKG_NAMES})
$(foreach pkg,${PKG_NAMES},$(eval uninstall@${pkg}: PKG_NAME=${pkg}))

uninstall:
	${RPM} -e \
		$(if ${SYSROOT},--root '${SYSROOT}') \
		$(foreach pkg,${PKG_NAMES},${${pkg}.RPMNAME})

$(addprefix uninstall@,${PKG_NAMES}):
	${RPM} -e \
		$(if ${SYSROOT},--root '${SYSROOT}') \
		${${PKG_NAME}.RPMNAME}

endif # __RPM_MK__
