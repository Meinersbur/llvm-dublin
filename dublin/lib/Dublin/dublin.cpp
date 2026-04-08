//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// Implementation of the Dublin library.
///
//===----------------------------------------------------------------------===//

#include "dublin/Dublin/dublin.h"
#include <iostream>


/// Implements "Hello World" in Irish.
extern "C" void _dublin_hello_world() {
  std::cout << "Dia daoibh, a dhomhain!" << std::endl;
}
