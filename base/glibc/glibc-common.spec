License: GPL-2.0-or-later, LGPL-2.1-or-later
Summary: GNU C Library - Programs and locale
URL: https://www.gnu.org/software/libc/

AutoReq: 0
Requires: glibc(%{_deparch}) = %{version}-%{release}
Requires: /bin/sh

%description
This package contains the programs and language packas shipped with glibc, the
GNU C library.

%transfiletriggerin -- /lib /usr/lib
printf "Running ldconfig...\n"
/sbin/ldconfig
