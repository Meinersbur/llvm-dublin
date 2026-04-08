//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// Demonstration of using CUDA in the LLVM build system.
///
//===----------------------------------------------------------------------===//

extern "C"
__device__ void _dublin_hello_world();

__global__ void hello_world_kernel()
{
    _dublin_hello_world();
}

int main()
{
    hello_world_kernel<<<1, 1>>>();
    cudaDeviceSynchronize();
}
