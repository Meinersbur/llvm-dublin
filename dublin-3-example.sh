#! /bin/bash
set -ex

# Preparation
cmake -B build                       \
      -S llvm                        \
      -D LLVM_ENABLE_RUNTIMES=dublin \
      -D DUBLIN_INCLUDE_EXAMPLES=ON
ninja -C build

cc dublin/examples/dublin-hello/dublin-hello.c                \
   -I dublin/include                                          \
   build/runtimes/runtimes-bins/dublin/lib/Dublin/libdublin.a \
   -o dublin-hello
./dublin-hello
rm ./dublin-hello

ninja -C build/runtimes/runtimes-bins dublin-hello -v
find -name dublin-hello -type f
./build/bin/dublin-hello
