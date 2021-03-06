if [[ $a == 0 ]] ; then
gcc $compile backtrace.c -o files/backtrace.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
ar cur files/backtrace.a files/backtrace.o libbacktrace/atomic.o libbacktrace/dwarf.o libbacktrace/fileline.o libbacktrace/posix.o libbacktrace/print.o libbacktrace/sort.o libbacktrace/state.o libbacktrace/backtrace.o libbacktrace/simple.o libbacktrace/elf.o libbacktrace/mmapio.o libbacktrace/mmap.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $share -o files/backtrace.so backtrace.c libbacktrace/.libs/atomic.o libbacktrace/.libs/dwarf.o libbacktrace/.libs/fileline.o libbacktrace/.libs/posix.o libbacktrace/.libs/print.o libbacktrace/.libs/sort.o libbacktrace/.libs/state.o libbacktrace/.libs/backtrace.o libbacktrace/.libs/simple.o libbacktrace/.libs/elf.o libbacktrace/.libs/mmapio.o libbacktrace/.libs/mmap.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $compile libstring.c -o files/libstring.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
ar cur files/libstring.a files/libstring.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $compile ${RE} -D__SHARED__ -o files/readelf_.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $compile readelf__min.c -o files/readelf_min.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
ar cur files/readelf_.a files/readelf_.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
ar cur files/readelf_min.a files/readelf_min.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $compile test_lib.c -o files/test_lib.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
ar cur files/test_lib.a files/test_lib.o
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $share libstring.c -o files/libstring.so
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $share ${RE} -D__SHARED__ -o files/readelf_.so -liberty
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $share readelf__min.c -o files/readelf_min.so -liberty
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $share test_lib.c test_lib2.c -o files/test_lib.so
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
g++ $share test++_lib.cpp test++_lib2.cpp -o files/test++_lib.so -std=c++11
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
g++ $share patchelf.cc -o files/patchelf.so -std=c++11
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $link ${RE} -o files/readelf_ files/readelf_.so files/patchelf.so files/libstring.so files/backtrace.so
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
g++ $link patchelf.cc -o files/patchelf ./files/libstring.a ./files/backtrace.a -DM -std=c++11
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
gcc $link test_loader.c -o files/loader files/readelf_.so files/patchelf.so files/libstring.so files/backtrace.so
a=$? ; else a=1 ; fi
# if [[ $a == 0 ]] ; then
# gcc $link test_loader.c -o files/loader_min files/readelf_min.so
# a=$? ; else ; a=1 ; fi
if [[ $a == 0 ]] ; then
cp -rv supplied examples/example1
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
cd examples/example1
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
rm example1 hello.so
fi # ignore example1 and hello.so if it does not exist
if [[ $a == 0 ]] ; then
make
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
# LD_PRELOAD=../../files/backtrace.so:../../files/libstring.so:../../files/patchelf.so:../../files/readelf_.so ./example1
# ./example1
# gdb ./example1 -ex "handle SIGSEGV nostop pass noprint" -ex "set environment LD_PRELOAD=../../files/backtrace.so:../../files/libstring.so:../../files/patchelf.so:../../files/readelf_.so"
cd ../../
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
./files/patchelf ldd examples/example1/hello.so
a=$? ; else a=1 ; fi
if [[ $a == 0 ]] ; then
./files/loader
fi
set +v

# gdb files/loader_min - ex "break 90" -ex "r"
# gdb ./files/loader -ex "r" -ex "break ${RE} -D__SHARED__:515"
# cd ../../
