// RUN: %cc -I "%dublin_source_dir/include" -L "%dublin_binary_dir/lib/Dublin" %s -ldublin -o %t.exe
// RUN: %t.exe | FileCheck %s

// CHECK: Dia daoibh, a dhomhain!

#include <dublin/Dublin/dublin.h>
#include <stdlib.h>

int main() {
  _dublin_hello_world();
  return EXIT_SUCCESS;
}
