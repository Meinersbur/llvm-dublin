#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

add_llvm_example(dublin-openmp
  dublin-openmp.c
)

set(offload_opts
  -flto
  -fopenmp
  -fopenmp-offload-mandatory
-fno-exceptions
  --offload-arch=native
  #--offload-arch=sm_80 # --offload-arch=gfx90a # Possible to add the native arch in addition?
#  --cuda-feature=+ptx63 -fconvergent-functions
# -nogpulib
-flto
  "SHELL:-Xoffload-linker -ldublin"
  "SHELL:-Xoffload-linker -lc"
-lomptarget
-lomp
#  "SHELL:-Xoffload-linker -lompdevice"
 -fuse-ld=lld
)
target_compile_options(dublin-openmp PRIVATE  ${offload_opts})
#target_link_libraries(dublin-openmp PRIVATE dublin.default)
target_link_options(dublin-openmp PRIVATE ${offload_opts} -ldublin)

