#! /bin/bash
set -ex

cmake -B build                       \
      -S llvm                        \
      -D LLVM_ENABLE_RUNTIMES=dublin

cd build
ninja dublin
find -name libdublin.a
