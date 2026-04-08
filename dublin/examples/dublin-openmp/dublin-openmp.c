//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// Demonstration of using target offloading in the LLVM build system.
///
//===----------------------------------------------------------------------===//

#include <stdlib.h>

#pragma omp declare target
void _dublin_hello_world(void);
#pragma omp end declare target

int main() {
  #pragma omp target
  {
    _dublin_hello_world();
  }
  return EXIT_SUCCESS;
}
