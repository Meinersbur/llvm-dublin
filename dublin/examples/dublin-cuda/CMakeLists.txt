#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

enable_language(CUDA)

add_llvm_example(dublin-cuda
  dublin-cuda.cu
)


target_include_directories(dublin-cuda PRIVATE ${include_dirs})
target_link_options(dublin-cuda PRIVATE "SHELL:-Xoffload-linker -ldublin" -ldublin --offload-new-driver)
target_link_options(dublin-cuda PRIVATE "SHELL:-Xoffload-linker -lc")
target_link_options(dublin-cuda PRIVATE "SHELL:-Xoffload-linker -ldublin" -fuse-ld=lld)
target_compile_options(dublin-cuda PUBLIC -flto -fuse-ld=lld --offload-new-driver)
target_compile_options(dublin-cuda PUBLIC  "SHELL:-Xoffload-linker -flto" -fgpu-rdc)
target_link_options(dublin-cuda PUBLIC -flto -fgpu-rdc )
target_link_options(dublin-cuda PRIVATE "SHELL:-Xoffload-linker -L/home/meinersbur/src/llvm/dublin/install/lib/clang/23/lib/amdgcn-amd-amdhsa")
target_link_options(dublin-cuda PRIVATE "SHELL:-Xoffload-linker -L/home/meinersbur/src/llvm/dublin/install/lib/amdgcn-amd-amdhsa")
