License: GPL-3.0-or-later, LGPL-3.0-or-later
Summary: GNU Compiler Collection - C++ compiler
URL: http://www.gnu.org/software/gcc/

Requires: gcc(%{_deparch}) = %{version}-%{release}
Requires: libstdc++-devel(%{_deparch}) = %{version}-%{release}

%description
This package provides g++, the C++ front end for GCC.
