#! /bin/bash
set -ex

cmake -B build-bootstrap                  \
      -S llvm                             \
      -D LLVM_ENABLE_PROJECTS="clang;lld" \
      -D LLVM_ENABLE_RUNTIMES=dublin

cd build-bootstrap
ninja dublin
find -name libdublin.a
