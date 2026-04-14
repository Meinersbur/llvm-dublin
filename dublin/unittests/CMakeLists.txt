#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

set(LLVM_BUILD_TESTS "${DUBLIN_BUILD_TESTS}")

build_gtest()

add_custom_target(DublinUnitTests)
add_dependencies(dublin-test-depends
  DublinUnitTests
  dublin.default
)

function(add_dublin_unittest testname)
  cmake_parse_arguments(ARG
    ""
    ""
    "LINK_LIBS"
    ${ARGN})

  add_unittest(DublinUnitTests ${testname} ${ARG_UNPARSED_ARGUMENTS})
  target_link_libraries(${testname} PRIVATE dublin.shared ${ARG_LINK_LIBS})
endfunction()

add_subdirectory(Dublin)
