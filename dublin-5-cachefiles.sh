#! /bin/bash
set -ex

# Preparation: LLVM build
cmake -B build-llvm                       \
      -S llvm                             \
      -D LLVM_ENABLE_PROJECTS="clang;lld"
ninja -C build-llvm

# Runtimes build
cmake -B build-runtimes                          \
      -S runtimes                                \
      -C dublin/cmake/caches/runtimes-bins.cmake

cd build-runtimes
ninja dublin
