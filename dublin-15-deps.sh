#! /bin/bash
set -ex

cmake -B build-bootstrap                                                      \
      -S llvm                                                                 \
      -D LLVM_ENABLE_PROJECTS="clang;lld"                                     \
      -D LLVM_ENABLE_RUNTIMES="compiler-rt;libunwind;libcxx;libcxxabi;dublin" \
      -D DUBLIN_INCLUDE_EXAMPLES=ON

cd build-bootstrap
ninja check-dublin
ninja -C runtimes/runtimes-bins dublin-hello
bin/dublin-hello

ninja check-compiler-rt
ninja check-dublin

