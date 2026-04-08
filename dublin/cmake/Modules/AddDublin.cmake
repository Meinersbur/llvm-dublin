#===------------------------------------------------------------------------===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

# Builds a library with common options of this runtime.
#
# Usage:
#
# add_dublin_library(name sources ...
#   SHARED
#     Build a dynamic (.so/.dll) library
#   STATIC
#     Build a static (.a/.lib) library
#   OBJECT
#     Always create an object library.
#     Without SHARED/STATIC, build only the object library.
# )
function (add_dublin_library name)
  set(options STATIC SHARED OBJECT)
  set(multiValueArgs "")
  cmake_parse_arguments(ARG
    "${options}"
    ""
    "${multiValueArgs}"
    ${ARGN})

  set(name_static "${name}.static")
  set(name_shared "${name}.shared")
  set(name_object "obj.${name}")
  if (ARG_STATIC AND NOT ARG_SHARED)
    set(name_static "${name}")
  elseif (NOT ARG_STATIC AND ARG_SHARED)
    set(name_shared "${name}")
  elseif (NOT ARG_STATIC AND NOT ARG_SHARED AND ARG_OBJECT)
    set(name_object "${name}")
  elseif (NOT ARG_STATIC AND NOT ARG_SHARED AND NOT ARG_OBJECT)
    # Only one of them will actually be built.
    set(name_static "${name}")
    set(name_shared "${name}")
  endif ()

  if (ARG_STATIC AND ARG_SHARED)
    set(build_static ${DUBLIN_ENABLE_STATIC})
    set(build_shared ${DUBLIN_ENABLE_SHARED})
  else ()
    set(build_static ${ARG_STATIC})
    set(build_shared ${ARG_SHARED})
  endif ()
  if (NOT ARG_STATIC AND NOT ARG_SHARED AND NOT ARG_OBJECT)
    if (BUILD_SHARED_LIBS)
      set(build_shared ON)
    else ()
      set(build_static ON)
    endif ()
  endif ()

  set(build_object OFF)
  if (ARG_OBJECT)
    set(build_object ON)
  elseif (build_static AND build_shared)
    set(build_object ON)
  endif ()

  set(srctargets "") # targets that contain source files
  set(libtargets "") # static/shared if they are built
  set(alltargets "") # any add_library target added by this function
  if (build_static)
    list(APPEND srctargets "${name_static}")
    list(APPEND libtargets "${name_static}")
    list(APPEND alltargets "${name_static}")
  endif ()
  if (build_shared)
    list(APPEND srctargets "${name_shared}")
    list(APPEND libtargets "${name_shared}")
    list(APPEND alltargets "${name_shared}")
  endif ()
  if (build_object)
    set(srctargets "${name_object}")
    list(APPEND alltargets "${name_object}")
  endif ()

  if (build_object)
    add_library("${name_object}" OBJECT ${ARG_UNPARSED_ARGUMENTS})
    set_target_properties(${name_object} PROPERTIES
        POSITION_INDEPENDENT_CODE ON
        FOLDER "Flang-RT/Object Libraries"
      )
    set(ARG_UNPARSED_ARGUMENTS "$<TARGET_OBJECTS:${name_object}>")
  endif ()
  if (build_static)
    add_library("${name_static}" STATIC ${extra_args} ${ARG_UNPARSED_ARGUMENTS})
  endif ()
  if (build_shared)
    add_library("${name_shared}" SHARED ${extra_args} ${ARG_UNPARSED_ARGUMENTS})
  endif ()

  if (libtargets)
    if (BUILD_SHARED_LIBS)
      if (build_shared)
        set(default_target "${name_shared}")
      else ()
        set(default_target "${name_static}")
      endif ()
    else ()
      if (build_static)
        set(default_target "${name_static}")
      else ()
        set(default_target "${name_shared}")
      endif ()
    endif ()
    add_library(${name}.default ALIAS "${default_target}")

    if (NOT TARGET ${name})
      add_custom_target(${name})
      add_dependencies(${name} ${libtargets})
    endif ()
  endif ()

  foreach (tgtname IN LISTS libtargets)
    set_target_properties(${tgtname} PROPERTIES OUTPUT_NAME "${name}")
  endforeach ()

  foreach (tgtname IN LISTS alltargets)
    target_include_directories(${tgtname} PUBLIC "${DUBLIN_SOURCE_DIR}/include")

    if (DUBLIN_OFFLOAD_BUILD)
      target_compile_options(${tgtname} PRIVATE -fgpu-rdc -nogpulib -fno-exceptions -flto)
    endif ()
  endforeach ()


if (TARGET cxx_static)
  foreach (tgtname IN LISTS libtargets)
    target_link_options(${tgtname} PRIVATE -nostdlib++)
  endforeach ()

  foreach (tgtname IN LISTS alltargets)
    target_link_libraries(${tgtname} PRIVATE cxx_static)
  endforeach ()

  foreach (tgtname IN LISTS srctargets)
      target_compile_options(${tgtname} PRIVATE -nostdinc++)
  endforeach ()
endif ()

  foreach (tgtname IN LISTS libtargets)
      set_target_properties(${tgtname}
        PROPERTIES
          ARCHIVE_OUTPUT_DIRECTORY "${DUBLIN_OUTPUT_RESOURCE_LIB_DIR}"
          LIBRARY_OUTPUT_DIRECTORY "${DUBLIN_OUTPUT_RESOURCE_LIB_DIR}"
        )

      install(TARGETS ${tgtname}
          ARCHIVE DESTINATION "${DUBLIN_INSTALL_RESOURCE_LIB_PATH}"
          LIBRARY DESTINATION "${DUBLIN_INSTALL_RESOURCE_LIB_PATH}"
        )
  endforeach ()
endfunction ()
