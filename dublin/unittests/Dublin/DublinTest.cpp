//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// Google Test for the Dublin library.
///
//===----------------------------------------------------------------------===//

#include "gtest/gtest.h"
#include "dublin/Dublin/dublin.h"

TEST(Dublin, Basic) {
  testing::internal::CaptureStdout();

  _dublin_hello_world();

  auto out = testing::internal::GetCapturedStdout();
  EXPECT_EQ(out, "Dia daoibh, a dhomhain!\n\n");
}
