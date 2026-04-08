#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

add_library(dublin
    dublin.c
  )

target_include_directories(dublin PUBLIC "${DUBLIN_SOURCE_DIR}/include")
set_target_properties(dublin
  PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${DUBLIN_OUTPUT_RESOURCE_LIB_DIR}"
)
