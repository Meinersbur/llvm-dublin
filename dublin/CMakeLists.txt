#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#
#
# Build instructions for the Dublin library.
#
#===------------------------------------------------------------------------===#


#####################
# CMake Environment #
#####################

set(LLVM_SUBPROJECT_TITLE "Dublin")
set(DUBLIN_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(DUBLIN_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")
set(LLVM_COMMON_CMAKE_UTILS "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
set(LLVM_RUNTIMES_CMAKE_UTILS "${CMAKE_CURRENT_SOURCE_DIR}/../runtimes/cmake")

list(APPEND CMAKE_MODULE_PATH
  "${DUBLIN_SOURCE_DIR}/cmake/Modules"
  "${LLVM_COMMON_CMAKE_UTILS}/Modules"
  "${LLVM_RUNTIMES_CMAKE_UTILS}/Modules"
)


##################
# Build Commands #
##################

add_custom_target(dublin
  COMMAND "${CMAKE_COMMAND}" -E echo "Executing the 'dublin' target"
  COMMENT "Echoing 'dublin'"
)

add_custom_target(check-dublin
  COMMAND "${CMAKE_COMMAND}" -E echo "Executing the 'check-dublin' target"
  COMMENT "Echoing 'check-dublin'"
)
