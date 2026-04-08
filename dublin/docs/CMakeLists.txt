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
