#include <cstring>

extern "C" void *__wrap_memcpy(void *dest, const void *src, size_t n)
{
  return memcpy(dest, src, n);
}
