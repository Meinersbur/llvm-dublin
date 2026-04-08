#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#


function (get_toolchain_library_subdir outvar)
  set(outval "lib")

  if (APPLE)
    # Required to be "darwin" for MachO toolchain.
    get_toolchain_os_dirname(os_dirname)
    set(outval "${outval}/${os_dirname}")
  else ()
    get_toolchain_arch_dirname(arch_dirname)
    set(outval "${outval}/${arch_dirname}")
  endif ()

  set(${outvar} "${outval}" PARENT_SCOPE)
endfunction ()


# Corresponds to Clang's ToolChain::getOSLibName(). Adapted from Compiler-RT.
function (get_toolchain_os_dirname outvar)
  if (ANDROID)
    # The CMAKE_SYSTEM_NAME for Android is "Android", but the OS is Linux and the
    # driver will search for libraries in the "linux" directory.
    set(outval "linux")
  else ()
    string(TOLOWER "${CMAKE_SYSTEM_NAME}" outval)
  endif ()
  set(${outvar} "${outval}" PARENT_SCOPE)
endfunction ()


# Corresponds to Clang's ToolChain::getRuntimePath(). Adapted from Compiler-RT.
function (get_toolchain_arch_dirname outvar)
  string(FIND ${LLVM_TARGET_TRIPLE} "-" dash_index)
  string(SUBSTRING ${LLVM_TARGET_TRIPLE} ${dash_index} -1 triple_suffix)
  string(SUBSTRING ${LLVM_TARGET_TRIPLE} 0 ${dash_index} triple_cpu)
  set(arch "${triple_cpu}")
  if("${arch}" MATCHES "^i.86$")
    # Android uses i686, but that's remapped at a later stage.
    set(arch "i386")
  endif()

  if(ANDROID AND ${arch} STREQUAL "i386")
    set(target "i686${triple_suffix}")
  elseif(${arch} STREQUAL "amd64")
    set(target "x86_64${triple_suffix}")
  elseif(${arch} STREQUAL "sparc64")
    set(target "sparcv9${triple_suffix}")
  elseif("${arch}" MATCHES "mips64|mips64el")
    string(REGEX REPLACE "-gnu.*" "-gnuabi64" triple_suffix_gnu "${triple_suffix}")
    string(REGEX REPLACE "mipsisa32" "mipsisa64" triple_cpu_mips "${triple_cpu}")
    string(REGEX REPLACE "^mips$" "mips64" triple_cpu_mips "${triple_cpu_mips}")
    string(REGEX REPLACE "^mipsel$" "mips64el" triple_cpu_mips "${triple_cpu_mips}")
    set(target "${triple_cpu_mips}${triple_suffix_gnu}")
  elseif("${arch}" MATCHES "mips|mipsel")
    string(REGEX REPLACE "-gnuabi.*" "-gnu" triple_suffix_gnu "${triple_suffix}")
    string(REGEX REPLACE "mipsisa64" "mipsisa32" triple_cpu_mips "${triple_cpu}")
    string(REGEX REPLACE "mips64" "mips" triple_cpu_mips "${triple_cpu_mips}")
    set(target "${triple_cpu_mips}${triple_suffix_gnu}")
  elseif("${arch}" MATCHES "^arm")
    # FIXME: Handle arch other than arm, armhf, armv6m
    if (${arch} STREQUAL "armhf")
      # If we are building for hard float but our ABI is soft float.
      if ("${triple_suffix}" MATCHES ".*eabi$")
        # Change "eabi" -> "eabihf"
        set(triple_suffix "${triple_suffix}hf")
      endif()
      # ABI is already set in the triple, don't repeat it in the architecture.
      set(arch "arm")
    else ()
      # If we are building for soft float, but the triple's ABI is hard float.
      if ("${triple_suffix}" MATCHES ".*eabihf$")
        # Change "eabihf" -> "eabi"
        string(REGEX REPLACE "hf$" "" triple_suffix "${triple_suffix}")
      endif()
    endif()
    set(target "${arch}${triple_suffix}")
  elseif("${arch}" MATCHES "^amdgcn")
    set(target "amdgcn-amd-amdhsa")
  elseif("${arch}" MATCHES "^nvptx")
    set(target "nvptx64-nvidia-cuda")
  else()
    set(target "${arch}${triple_suffix}")
  endif()
  set(${outvar} "${target}" PARENT_SCOPE)
endfunction()
