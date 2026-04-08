#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

enable_language(HIP)


#target_link_options(dublin-hip PRIVATE -ldublin)
#target_compile_options(dublin-hip PRIVATE  "SHELL:-Xoffload-linker -ldublin")
#target_link_options(dublin-hip PRIVATE  "SHELL:-Xoffload-linker -ldublin")
#target_link_options(dublin-hip PRIVATE  "SHELL:-Xoffload-linker -L/c/Users/meinersbur/src/llvm/dublin-14-offload/_src/build-bootstrap/lib/clang/23/lib/nvptx64-nvidia-cuda")


set(GPU_RUNTIME "HIP" CACHE STRING "Switches between HIP and CUDA")
set(GPU_RUNTIMES "HIP" "CUDA")
set_property(CACHE GPU_RUNTIME PROPERTY STRINGS ${GPU_RUNTIMES})

if(NOT "${GPU_RUNTIME}" IN_LIST GPU_RUNTIMES)
    set(ERROR_MESSAGE
        "GPU_RUNTIME is set to \"${GPU_RUNTIME}\".\nGPU_RUNTIME must be either HIP or CUDA."
    )
    message(FATAL_ERROR ${ERROR_MESSAGE})
endif()

enable_language(${GPU_RUNTIME})
set(CMAKE_${GPU_RUNTIME}_STANDARD 17)
set(CMAKE_${GPU_RUNTIME}_EXTENSIONS OFF)
set(CMAKE_${GPU_RUNTIME}_STANDARD_REQUIRED ON)


    set(ROCM_ROOT
        "/opt/rocm"
        CACHE PATH
        "Root directory of the ROCm installation"
    )


list(APPEND CMAKE_PREFIX_PATH "${ROCM_ROOT}")

set(example_name dublin-hip)

add_llvm_example(${example_name} dublin-hip.hip)
# Make example runnable using ctest
add_test(NAME ${example_name} COMMAND ${example_name})

set(include_dirs "../../Common" "../../External")
# For examples targeting NVIDIA, include the HIP header directory.
if(GPU_RUNTIME STREQUAL "CUDA")
    list(APPEND include_dirs "${ROCM_ROOT}/include")
endif()

target_include_directories(${example_name} PRIVATE ${include_dirs})
target_link_options(${example_name} PRIVATE "SHELL:-Xoffload-linker -ldublin" -ldublin --offload-new-driver)
target_link_options(${example_name} PRIVATE "SHELL:-Xoffload-linker -lc")
target_link_options(${example_name} PRIVATE "SHELL:-Xoffload-linker -ldublin" -fuse-ld=lld)
target_compile_options(${example_name} PUBLIC -flto -fuse-ld=lld --offload-new-driver)
target_compile_options(${example_name} PUBLIC  "SHELL:-Xoffload-linker -flto" -fgpu-rdc)
target_link_options(${example_name} PUBLIC -flto -fgpu-rdc )
target_link_options(${example_name} PRIVATE "SHELL:-Xoffload-linker -L/home/meinersbur/src/llvm/dublin/install/lib/clang/23/lib/amdgcn-amd-amdhsa")
target_link_options(${example_name} PRIVATE "SHELL:-Xoffload-linker -L/home/meinersbur/src/llvm/dublin/install/lib/amdgcn-amd-amdhsa")
set_source_files_properties(main.hip PROPERTIES LANGUAGE ${GPU_RUNTIME})
