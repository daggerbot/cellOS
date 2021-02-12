License: GPL-3.0-or-later, LGPL-3.0-or-later
Summary: GNU Compiler Collection - Base compilers
URL: http://www.gnu.org/software/gcc/

Requires: binutils(%{_deparch})
Requires: gcc-libs(%{_deparch}) = %{version}-%{release}

%description
The GNU Compiler Collection includes front ends for C, C++, Objective-C,
Fortran, Ada, Go, and D, as well as libraries for these languages
(libstdc++,...). GCC was originally written as the compiler for the GNU
operating system. The GNU system was developed to be 100% free software, free
in the sense that it respects the user's freedom. This package provides the
front end for C.
