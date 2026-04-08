#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

set(LLVM_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/../build-llvm" CACHE STRING "Initial cache")
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Initial cache")
set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/install/dublin" CACHE STRING "Initial cache")
set(LLVM_ENABLE_RUNTIMES "dublin" CACHE STRING "Initial cache")

set(CMAKE_ASM_COMPILER "${LLVM_BINARY_DIR}/bin/clang" CACHE STRING "Initial cache")
set(CMAKE_C_COMPILER "${LLVM_BINARY_DIR}/bin/clang" CACHE STRING "Initial cache")
set(CMAKE_CXX_COMPILER "${LLVM_BINARY_DIR}/bin/clang++" CACHE STRING "Initial cache")
set(CMAKE_LINKER "${LLVM_BINARY_DIR}/bin/ld.lld" CACHE STRING "Initial cache")
set(CMAKE_AR "${LLVM_BINARY_DIR}/bin/llvm-ar" CACHE STRING "Initial cache")
set(CMAKE_RANLIB "${LLVM_BINARY_DIR}/bin/llvm-ranlib" CACHE STRING "Initial cache")
set(CMAKE_NM "${LLVM_BINARY_DIR}/bin/llvm-nm" CACHE STRING "Initial cache")
set(CMAKE_OBJDUMP "${LLVM_BINARY_DIR}/bin/llvm-objdump" CACHE STRING "Initial cache")
set(CMAKE_OBJCOPY "${LLVM_BINARY_DIR}/bin/llvm-objcopy" CACHE STRING "Initial cache")
set(CMAKE_STRIP "${LLVM_BINARY_DIR}/bin/llvm-strip" CACHE STRING "Initial cache")
set(CMAKE_READELF "${LLVM_BINARY_DIR}/bin/llvm-readelf" CACHE STRING "Initial cache")
set(CMAKE_MAKE_PROGRAM "ninja" CACHE FILEPATH "Initial cache")
set(LLVM_CONFIG_PATH "${LLVM_BINARY_DIR}/bin/llvm-config" CACHE STRING "Initial cache")

set(CMAKE_ASM_COMPILER_TARGET "x86_64-unknown-linux-gnu" CACHE STRING "Initial cache")
set(CMAKE_C_COMPILER_TARGET "x86_64-unknown-linux-gnu" CACHE STRING "Initial cache")
set(CMAKE_CXX_COMPILER_TARGET "x86_64-unknown-linux-gnu" CACHE STRING "Initial cache")
set(CMAKE_Fortran_COMPILER_TARGET "x86_64-unknown-linux-gnu" CACHE STRING "Initial cache")
set(LLVM_HOST_TRIPLE "x86_64-unknown-linux-gnu" CACHE STRING "Initial cache")
set(LLVM_DEFAULT_TARGET_TRIPLE "x86_64-unknown-linux-gnu" CACHE STRING "Initial cache")

set(CMAKE_ASM_COMPILER_WORKS "ON" CACHE BOOL "Initial cache")
set(CMAKE_C_COMPILER_WORKS "ON" CACHE BOOL "Initial cache")
set(CMAKE_CXX_COMPILER_WORKS "ON" CACHE BOOL "Initial cache")
set(CMAKE_Fortran_COMPILER_WORKS "ON" CACHE BOOL "Initial cache")

set(LLVM_ENABLE_WERROR "OFF" CACHE BOOL "Initial cache")
set(LLVM_HAVE_LINK_VERSION_SCRIPT "1" CACHE BOOL "Initial cache")
set(LLVM_USE_RELATIVE_PATHS_IN_DEBUG_INFO "OFF" CACHE BOOL "Initial cache")
set(LLVM_USE_RELATIVE_PATHS_IN_FILES "OFF" CACHE BOOL "Initial cache")

set(LLVM_LIT_ARGS "-sv" CACHE STRING "Initial cache")
set(LLVM_SOURCE_PREFIX "" CACHE STRING "Initial cache")
set(PACKAGE_VERSION "23.0.0git" CACHE STRING "Initial cache")

set(CMAKE_EXPORT_COMPILE_COMMANDS "1" CACHE BOOL "Initial cache")
set(COMPILER_RT_BUILD_BUILTINS "OFF" CACHE BOOL "Initial cache")
set(LLVM_INCLUDE_TESTS "ON" CACHE BOOL "Initial cache")
set(LLVM_ENABLE_PROJECTS_USED "ON" CACHE BOOL "Initial cache")
set(LLVM_ENABLE_PER_TARGET_RUNTIME_DIR "ON" CACHE BOOL "Initial cache")
set(LLVM_BUILD_TOOLS "ON" CACHE BOOL "Initial cache")
set(LLVM_ENABLE_DOXYGEN "OFF" CACHE BOOL "Initial cache")

set(HAVE_LLVM_LIT "ON" CACHE BOOL "Initial cache")
set(CLANG_RESOURCE_DIR "" CACHE PATH "Initial cache")
set(COMPILER_RT_TEST_EXTERNAL_BUILTINS "ON" CACHE BOOL "Initial cache")

set(FFI_INCLUDE_DIR "" CACHE PATH "Initial cache")
set(FFI_LIBRARY_DIR "" CACHE PATH "Initial cache")
set(LibEdit_INCLUDE_DIRS "LibEdit_INCLUDE_DIRS-NOTFOUND" CACHE STRING "Initial cache")
set(LibEdit_LIBRARIES "LibEdit_LIBRARIES-NOTFOUND" CACHE STRING "Initial cache")
set(ZLIB_INCLUDE_DIR "/usr/include" CACHE PATH "Initial cache")
set(zstd_INCLUDE_DIR "/usr/include" CACHE PATH "Initial cache")
set(zstd_LIBRARY "/usr/lib/x86_64-linux-gnu/libzstd.so" CACHE FILEPATH "Initial cache")
set(LIBXML2_LIBRARY "/usr/lib/x86_64-linux-gnu/libxml2.so" CACHE FILEPATH "Initial cache")
set(LIBXML2_INCLUDE_DIR "/usr/include/libxml2" CACHE PATH "Initial cache")
