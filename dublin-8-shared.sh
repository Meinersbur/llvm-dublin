#! /bin/bash
set -ex

# Projects build
cmake -B build-llvm                       \
      -S llvm                             \
      -D LLVM_ENABLE_PROJECTS="clang;lld"
ninja -C build-llvm

# Runtimes build (static by default)
cmake -B build-runtimes-static       \
      -S runtimes                    \
      -D LLVM_BINARY_DIR=build-llvm  \
      -D LLVM_ENABLE_RUNTIMES=dublin \
      -D DUBLIN_INCLUDE_EXAMPLES=ON  \
      -D DUBLIN_ENABLE_STATIC=ON     \
      -D DUBLIN_ENABLE_SHARED=OFF    \
      -D BUILD_SHARED_LIBS=OFF

# Runtimes build (shared by default)
cmake -B build-runtimes-shared       \
      -S runtimes                    \
      -D LLVM_BINARY_DIR=build-llvm  \
      -D LLVM_ENABLE_RUNTIMES=dublin \
      -D DUBLIN_INCLUDE_EXAMPLES=ON  \
      -D DUBLIN_ENABLE_STATIC=ON     \
      -D DUBLIN_ENABLE_SHARED=ON     \
      -D BUILD_SHARED_LIBS=ON        \


cd build-runtimes-static
ninja dublin-hello
find -name "libdublin.*"
LD_DEBUG=libs bin/dublin-hello
ninja dublin.static
find -name "libdublin.*"
cd ..

cd build-runtimes-shared
ninja dublin-hello
find -name "libdublin.*"
LD_DEBUG=libs bin/dublin-hello
ninja dublin
find -name "libdublin.*"
