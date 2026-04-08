# ===----------------------------------------------------------------------=== #
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# ===----------------------------------------------------------------------=== #

import os
import lit.formats

config.name = "Dublin-Unit"
config.suffixes = []
config.test_source_root = os.path.join(config.dublin_binary_dir, "unittests")
config.test_exec_root = config.dublin_binary_test_dir
config.test_format = lit.formats.GoogleTest(config.llvm_build_mode, "Tests")
