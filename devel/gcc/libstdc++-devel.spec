License: GPL-3.0-or-later, LGPL-3.0-or-later
Summary: GNU Compiler Collection - C++ library development files
URL: http://www.gnu.org/software/gcc/

Autoreq: 0
Requires: glibc-devel(%{_deparch})
Requires: libstdc++(%{_deparch}) = %{version}-%{release}

%description
This package provides the development files for libstdc++, the C standard
library implementation that ships with GCC.
