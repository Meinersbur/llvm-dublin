#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

configure_lit_site_cfg(
  "${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in"
  "${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py"
  MAIN_CONFIG
  "${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py"
)

configure_lit_site_cfg(
  "${CMAKE_CURRENT_SOURCE_DIR}/Unit/lit.site.cfg.py.in"
  "${CMAKE_CURRENT_BINARY_DIR}/Unit/lit.site.cfg.py"
  MAIN_CONFIG
  "${CMAKE_CURRENT_SOURCE_DIR}/Unit/lit.cfg.py"
)

add_custom_target(dublin-test-depends)
add_dependencies(dublin-test-depends dublin)

add_lit_testsuite(check-dublin "Running Dublin regression tests" "${CMAKE_CURRENT_BINARY_DIR}"
  DEPENDS dublin-test-depends
)

add_lit_testsuites(dublin "${CMAKE_CURRENT_SOURCE_DIR}"
  DEPENDS dublin-test-depends
)
