#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

include(AddSphinxTarget)

set(LLVM_BUILD_DOCS "${DUBLIN_BUILD_DOCS}")

if (LLVM_ENABLE_SPHINX AND SPHINX_FOUND AND SPHINX_OUTPUT_HTML)
  add_sphinx_target(html dublin)
endif ()


if (LLVM_ENABLE_DOXYGEN AND DOXYGEN_FOUND)
  if (NOT HAVE_DOT)
    set(LLVM_PATH_DOT "") # Avoid 'dot-NOTFOUND' to appear in the config file
  endif ()

  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/doxygen.cfg.in" "${CMAKE_CURRENT_BINARY_DIR}/doxygen.cfg" @ONLY)

  add_custom_target(doxygen-dublin
    COMMAND "${DOXYGEN_EXECUTABLE}" "${CMAKE_CURRENT_BINARY_DIR}/doxygen.cfg"
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    COMMENT "Generating Dublin doxygen documentation." VERBATIM
  )

  if (LLVM_BUILD_DOCS)
    add_dependencies(doxygen doxygen-dublin)
  endif ()

  install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/doxygen/html" DESTINATION docs/html)
endif ()
