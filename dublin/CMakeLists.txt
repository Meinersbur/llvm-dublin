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


#################
# Build Options #
#################

option(DUBLIN_BUILD_EXAMPLES "Build examples" OFF)
option(DUBLIN_INCLUDE_EXAMPLES "Generate build targets for tests" ON)


###################
# Build Artifacts #
###################

add_subdirectory(lib)

if (DUBLIN_INCLUDE_EXAMPLES)
  add_subdirectory(examples)
endif ()
