#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

set(LLVM_BUILD_EXAMPLES "${DUBLIN_BUILD_EXAMPLES}")

add_llvm_example(dublin-hello
  dublin-hello.c
)
target_link_libraries(dublin-hello PRIVATE dublin)
target_include_directories(dublin-hello PRIVATE "${DUBLIN_SOURCE_DIR}/include")
