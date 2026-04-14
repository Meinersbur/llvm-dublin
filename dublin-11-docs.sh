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
      -D DUBLIN_INCLUDE_DOCS=ON             \
      -D DUBLIN_BUILD_DOCS=ON               \
      -D LLVM_ENABLE_SPHINX=ON              \
      -D LLVM_BUILD_DOCS=ON  


cd build-runtimes
ninja docs-dublin-html
find -name "*.html"
