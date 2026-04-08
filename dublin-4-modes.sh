#! /bin/bash
set -ex

# Preparation: LLVM build
cmake -B build-llvm                       \
      -S llvm                             \
      -D LLVM_ENABLE_PROJECTS="clang;lld"
ninja -C build-llvm

# 1. Legacy standalone build
cmake -B build-standalone \
      -S dublin

# 2. Legacy LLVM_ENABLE_PROJECTS build
cmake -B build-projects              \
      -S llvm                        \
      -D LLVM_ENABLE_PROJECTS=dublin

# 3. Runtimes bootstrapping build
cmake -B build-bootstrapping         \
      -S llvm                        \
      -D LLVM_ENABLE_RUNTIMES=dublin

# 4. Runtimes default/standalone build
cmake -B build-runtimes              \
      -S runtimes                    \
      -D LLVM_ENABLE_RUNTIMES=dublin

# 5. Runtimes default/standalone build with LLVM build dir
cmake -B build-runtimes                      \
      -S runtimes                            \
      -D LLVM_ENABLE_RUNTIMES=dublin         \
      -D LLVM_BINARY_DIR=build               \
      -D CMAKE_C_COMPILER=build/bin/clang    \
      -D CMAKE_CXX_COMPILER=build/bin/clang+

# 6. Runtimes default/standalone build with LLVM install dir
cmake -B build-runtimes                        \
      -S runtimes                              \
      -D LLVM_ENABLE_RUNTIMES=dublin           \
      -D LLVM_BINARY_DIR=install               \
      -D CMAKE_C_COMPILER=install/bin/clang    \
      -D CMAKE_CXX_COMPILER=install/bin/clang+


cd build-runtimes
ninja dublin
