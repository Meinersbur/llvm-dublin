//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// Example that uses the Dublin library.
///
//===----------------------------------------------------------------------===//

#include "dublin/Dublin/dublin.h"
#include <stdlib.h>

int main(int argc, const char *argv[]) {
  _dublin_hello_world();
  return EXIT_SUCCESS ;
}
