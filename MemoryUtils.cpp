/*
   This file is part of the Eagle haplotype phasing software package
   developed by Po-Ru Loh.  Copyright (C) 2015-2018 Harvard University.
*/

#include "MemoryUtils.hpp"
#include <stdlib.h>

void *ALIGNED_MALLOC(uint64 size) {
#ifdef USE_MKL_MALLOC
    return mkl_malloc(size, MEM_ALIGNMENT);
#else
    #if defined(__x86_64__) || defined(_M_X64)
        void *p = nullptr;
        if (posix_memalign(&p, MEM_ALIGNMENT, size) != 0) {
            return nullptr;
        }
        return p;
    #else
        void *p = nullptr;
        if (posix_memalign(&p, MEM_ALIGNMENT, size) != 0) {
            return nullptr;
        }
        return p;
    #endif
#endif
}
