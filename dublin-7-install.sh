#! /bin/bash
set -ex

# LLVM build
cmake -B build-llvm                       \
      -S llvm                             \
      -D LLVM_ENABLE_PROJECTS="clang;lld" \
      -D CMAKE_INSTALL_PREFIX=install
ninja -C build-llvm install

# runtimes build
cmake -B build-runtimes               \
      -S runtimes                     \
      -D LLVM_BINARY_DIR=build-llvm   \
      -D LLVM_ENABLE_RUNTIMES=dublin  \
      -D CMAKE_INSTALL_PREFIX=install

cd build-runtimes
ninja all
ninja install
