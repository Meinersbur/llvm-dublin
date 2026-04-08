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

include(GetClangResourceDir)
include(GetToolchainDirs)
include(ExtendPath)


############################
# Build Mode Introspection #
############################

if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  message(FATAL_ERROR "Standalone build mode not supported")
endif ()

if (NOT LLVM_RUNTIMES_BUILD)
  message(FATAL_ERROR "Runtimes build required")
endif ()


get_toolchain_library_subdir(toolchain_lib_subdir)
if (LLVM_TREE_AVAILABLE)
  get_clang_resource_dir(DUBLIN_OUTPUT_RESOURCE_DIR PREFIX "${LLVM_LIBRARY_OUTPUT_INTDIR}/..")
  get_clang_resource_dir(DUBLIN_INSTALL_RESOURCE_PATH)

  extend_path(DUBLIN_OUTPUT_RESOURCE_LIB_DIR "${DUBLIN_OUTPUT_RESOURCE_DIR}" "${toolchain_lib_subdir}")
else ()
  set(DUBLIN_OUTPUT_RESOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}")
  set(DUBLIN_INSTALL_RESOURCE_PATH "lib${LLVM_LIBDIR_SUFFIX}/clang/${LLVM_VERSION_MAJOR}")

  extend_path(DUBLIN_OUTPUT_RESOURCE_LIB_DIR "${DUBLIN_OUTPUT_RESOURCE_DIR}" "lib${LLVM_LIBDIR_SUFFIX}")
endif ()

extend_path(DUBLIN_INSTALL_RESOURCE_LIB_PATH "${DUBLIN_INSTALL_RESOURCE_PATH}" "${toolchain_lib_subdir}")
cmake_path(NORMAL_PATH DUBLIN_OUTPUT_RESOURCE_DIR)
cmake_path(NORMAL_PATH DUBLIN_INSTALL_RESOURCE_PATH)
cmake_path(NORMAL_PATH DUBLIN_OUTPUT_RESOURCE_LIB_DIR)
cmake_path(NORMAL_PATH DUBLIN_INSTALL_RESOURCE_LIB_PATH)


#################
# Build Options #
#################

option(DUBLIN_ENABLE_STATIC "Build libdublin.a" ON)
option(DUBLIN_ENABLE_SHARED "Build libdublin.so" ON)


option(DUBLIN_BUILD_EXAMPLES "Build examples" OFF)
option(DUBLIN_INCLUDE_EXAMPLES "Generate build targets for tests" ON)


###################
# Build Artifacts #
###################

add_subdirectory(lib)
add_subdirectory(include)

if (DUBLIN_INCLUDE_EXAMPLES)
  add_subdirectory(examples)
endif ()
