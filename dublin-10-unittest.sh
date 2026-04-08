#! /bin/bash
set -ex

# Projects build
cmake -B build-llvm                       \
      -S llvm                             \
      -D LLVM_ENABLE_PROJECTS="clang;lld"
ninja -C build-llvm

# Runtimes build
cmake -B build-runtimes                     \
      -S runtimes                           \
      -D LLVM_BINARY_DIR="`pwd`/build-llvm" \
      -D LLVM_ENABLE_RUNTIMES=dublin        \
      -D LLVM_LIT_ARGS=""

cd build-runtimes
ninja check-dublin
