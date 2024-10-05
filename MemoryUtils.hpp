/*
   This file is part of the Eagle haplotype phasing software package
   developed by Po-Ru Loh.  Copyright (C) 2015-2018 Harvard University.
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef MEMORYUTILS_HPP
#define MEMORYUTILS_HPP

#include "Types.hpp"
#include <stdlib.h>

#define MEM_ALIGNMENT 64

#ifdef USE_MKL_MALLOC
    #include <mkl.h>
    #define ALIGNED_FREE mkl_free
#else
    #if defined(__x86_64__) || defined(_M_X64)
        #define ALIGNED_FREE free
    #else
        #define ALIGNED_FREE free
    #endif
#endif

void *ALIGNED_MALLOC(uint64 size);

#define ALIGNED_MALLOC_DOUBLES(numDoubles) (double *) ALIGNED_MALLOC((numDoubles)*sizeof(double))
#define ALIGNED_MALLOC_FLOATS(numFloats) (float *) ALIGNED_MALLOC((numFloats)*sizeof(float))
#define ALIGNED_MALLOC_UCHARS(numUchars) (uchar *) ALIGNED_MALLOC((numUchars)*sizeof(uchar))
#define ALIGNED_MALLOC_UINTS(numUints) (uint *) ALIGNED_MALLOC((numUints)*sizeof(uint))
#define ALIGNED_MALLOC_UINT64S(numUint64s) (uint64 *) ALIGNED_MALLOC((numUint64s)*sizeof(uint64))
#define ALIGNED_MALLOC_UINT64_MASKS(numUint64_masks) (uint64_masks *) ALIGNED_MALLOC((numUint64_masks)*sizeof(uint64_masks))

#endif
