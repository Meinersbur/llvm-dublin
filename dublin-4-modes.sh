#! /bin/bash
set -ex

# Preparation: LLVM build
cmake -B build-llvm                              \
      -S llvm                                    \
      -D LLVM_ENABLE_PROJECTS="clang;lld"        \
      -D CMAKE_INSTALL_PREFIX=`pwd`/install-llvm
ninja -C build-llvm install

# 1. Legacy standalone build
cmake -B build-standalone \
      -S dublin           \
      || true

# 2. Legacy LLVM_ENABLE_PROJECTS build
cmake -B build-projects              \
      -S llvm                        \
      -D LLVM_ENABLE_PROJECTS=dublin \
      || true

# 3. Runtimes bootstrapping build
cmake -B build-bootstrapping         \
      -S llvm                        \
      -D LLVM_ENABLE_RUNTIMES=dublin

# 4. Runtimes default/standalone build
cmake -B build-runtimes              \
      -S runtimes                    \
      -D LLVM_ENABLE_RUNTIMES=dublin

# 5. Runtimes default/standalone build with LLVM build dir
cmake -B build-runtimes-llvmbuild                        \
      -S runtimes                                        \
      -D LLVM_ENABLE_RUNTIMES=dublin                     \
      -D LLVM_BINARY_DIR=`pwd`/build-llvm                \
      -D CMAKE_C_COMPILER=`pwd`/build-llvm/bin/clang     \
      -D CMAKE_CXX_COMPILER=`pwd`/build-llvm/bin/clang++

# 6. Runtimes default/standalone build with LLVM install dir
cmake -B build-runtimes-llvminstall                        \
      -S runtimes                                          \
      -D LLVM_ENABLE_RUNTIMES=dublin                       \
      -D LLVM_BINARY_DIR=`pwd`/install-llvm                \
      -D CMAKE_C_COMPILER=`pwd`/install-llvm/bin/clang     \
      -D CMAKE_CXX_COMPILER=`pwd`/install-llvm/bin/clang++


cd build-runtimes
ninja dublin
