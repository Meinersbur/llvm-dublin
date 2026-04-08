#! /bin/bash
set -ex

# Add ports.ubuntu.com/ubuntu-ports/ lines to sources.lists
#  Types: deb
#  URIs: http://ports.ubuntu.com/ubuntu-ports
#  Suites: noble noble-updates noble-backports noble-security
#  Components: main universe restricted multiverse
#  Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
#  Architectures: arm64
# sudo dpkg --add-architecture arm64
# sudo apt update
# sudo apt install crossbuild-essential-arm64 libz-dev:arm64

cmake -B build-bootstrap                                                                   \
      -S llvm                                                                              \
      -D CMAKE_INSTALL_PREFIX=install                                                      \
      -D LLVM_ENABLE_PROJECTS="clang;lld"                                                  \
      -D LLVM_ENABLE_RUNTIMES=dublin                                                       \
      -D LLVM_RUNTIME_TARGETS="default;aarch64-linux-gnu"                                  \
      -D RUNTIMES_CMAKE_ARGS=-DLLVM_USE_LINKER=lld                                         \
      -D RUNTIMES_aarch64-linux-gnu_ZLIB_LIBRARY_RELEASE=/usr/lib/aarch64-linux-gnu/libz.a


cd build-bootstrap
ninja dublin
find -name "libdublin.*"
ninja install


cd ../install
find -name "libdublin.*"
