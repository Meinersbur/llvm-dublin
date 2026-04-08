#! /bin/bash
set -ex

# Add ports.ubuntu.com/ubuntu-ports/ lines to sources.lists
# sudo dpkg --add-architecture arm64
# sudo apt update
# sudo apt install crossbuild-essential-arm64 libz-dev:arm64 linux-libc-dev-amd64-cross

cmake -B build-bootstrap                                                                                     \
      -S llvm                                                                                                \
      -C offload/cmake/caches/Offload.cmake  \
      -D CMAKE_INSTALL_PREFIX=`pwd`/install                                                                  \
      -D LLVM_ENABLE_PROJECTS="clang;lld" \
      -D LLVM_ENABLE_RUNTIMES="compiler-rt;openmp;offload;dublin"                 \
      -D RUNTIMES_nvptx64-nvidia-cuda_LLVM_ENABLE_RUNTIMES="compiler-rt;libc;openmp;dublin"                 \
      -D RUNTIMES_nvptx64-nvidia-cuda_CMAKE_C_FLAGS="-march=sm_89"   \
      -D RUNTIMES_amdgcn-amd-amdhsa_LLVM_ENABLE_RUNTIMES="compiler-rt;libc;openmp;dublin"                 \
      -D LLVM_RUNTIME_TARGETS="default;amdgcn-amd-amdhsa;nvptx64-nvidia-cuda"                                \
      -D LLVM_ENABLE_ZLIB=OFF                                                                   \
      -D LLVM_INCLUDE_TESTS=OFF \
      -D DUBLIN_ENABLE_SHARED=OFF

#      -D RUNTIMES_nvptx64-nvidia-cuda_LLVM_ENABLE_RUNTIMES="compiler-rt;libc;openmp;libcxx;libcxxabi;dublin" \
#      -D RUNTIMES_amdgcn-amd-amdhsa_LLVM_ENABLE_RUNTIMES="compiler-rt;libc;openmp;libcxx;libcxxabi;dublin"   \
#      -D LLVM_ENABLE_ZLIB=OFF                                                                   \


cd build-bootstrap
ninja runtimes
find -name "libdublin.*"
ar x ./lib/clang/23/lib/amdgcn-amd-amdhsa/libdublin.a dublin.c.o
ar x ./lib/clang/23/lib/nvptx64-nvidia-cuda/libdublin.a dublin.c.o
file dublin.c.o
#bin/opt dublin.c.o -S
ninja install
cd -

cmake -B build-runtimes             \
  -S runtimes                            \
  -D LLVM_ENABLE_RUNTIMES=dublin \
  -D DUBLIN_INCLUDE_EXAMPLES=ON \
  -D DUBLIN_INCLUDE_TESTS=OFF \
  -D CMAKE_C_COMPILER=`pwd`/install/bin/clang \
  -D CMAKE_CXX_COMPILER=`pwd`/install/bin/clang++ \
  -D CMAKE_HIP_COMPILER=`pwd`/install/bin/clang++ \
  -D CMAKE_CUDA_COMPILER=`pwd`/install/bin/clang++ \
    -D CMAKE_CUDA_HOST_COMPILER=`pwd`/install/bin/clang++ \
  -D DUBLIN_ENABLE_SHARED=OFF \
  -D DUBLIN_ENABLE_STATIC=OFF \
  -D CMAKE_CUDA_ARCHITECTURES=all
  


#   -D LLVM_BINARY_DIR=`pwd`/install \

cd build-runtimes
ninja dublin-openmp dublin-cuda dublin-hip -v
LD_LIBRARY_PATH=../install/lib/x86_64-unknown-linux-gnu:../install/lib/clang/23/lib/x86_64-unknown-linux-gnu/:/usr/lib/wsl/lib ./bin/dublin-openmp
