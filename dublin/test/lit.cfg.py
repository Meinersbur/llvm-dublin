# ===----------------------------------------------------------------------=== #
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# ===----------------------------------------------------------------------=== #

import lit
from lit.llvm import llvm_config
from lit.llvm.subst import ToolSubst

config.name = "Dublin"
config.test_format = lit.formats.ShTest()
config.suffixes = [".c"]
config.test_source_root = os.path.dirname(__file__)
config.test_exec_root = config.dublin_binary_test_dir

lit_config.note(f"Using test compiler: {config.dublin_test_c_compiler}")

llvm_config.with_environment(
    "LD_LIBRARY_PATH",
    config.dublin_libshared_dir,
    append_path=True,  # There is no prepend_path=True
)

llvm_config.use_default_substitutions()
config.substitutions.append(("%dublin_source_dir", config.dublin_source_dir))
config.substitutions.append(("%dublin_binary_dir", config.dublin_binary_dir))
llvm_config.add_tool_substitutions(
    [
        ToolSubst(
            "%cc",
            command=config.dublin_test_c_compiler,
            unresolved="fatal",
        )
    ]
)
