# ===----------------------------------------------------------------------=== #
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# ===----------------------------------------------------------------------=== #

from datetime import date

project = "Dublin"
copyright = f"2026-{date.today().year}, Michael Kruse/AMD"

master_doc = "index"
source_suffix = [".rst", ".md"]

extensions = ["myst_parser"]

html_theme = "llvm-theme"
html_theme_path = ["_themes"]
pygments_style = "friendly"
