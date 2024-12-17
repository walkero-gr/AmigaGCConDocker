#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>
#include <wchar.h>

int main() {
  printf("Size of bool: %zu bytes\n", sizeof(bool));
  printf("Size of short: %zu bytes\n", sizeof(short));
  printf("Size of int: %zu bytes\n", sizeof(int));
  printf("Size of long: %zu bytes\n", sizeof(long));
  printf("Size of long long: %zu bytes\n", sizeof(long long));
  printf("Size of float: %zu bytes\n", sizeof(float));
  printf("Size of double: %zu bytes\n", sizeof(double));
  printf("Size of long double: %zu bytes\n", sizeof(long double));
  printf("Size of pointer: %zu bytes\n", sizeof(void *));
  printf("Size of size_t: %zu bytes\n", sizeof(size_t));
  printf("Size of wchar_t: %zu bytes\n", sizeof(wchar_t));

  return 0;
}