LBLAS = -lopenblas
BLAS_DIR = /opt/homebrew/opt/openblas/lib
BOOST_INSTALL_DIR = /opt/homebrew/opt/boost
HTSLIB_DIR = /opt/homebrew/opt/htslib
LIBOMP_DIR = /opt/homebrew/opt/libomp

# Set default linking if not specified
ifeq ($(strip ${linking}),)
	linking = dynamic
endif

# Use clang++ as the compiler for Mac
CC = clang++

# Debug flags
ifeq (${debug},true)
	CFLAGS += -g
else
	CFLAGS += -O2
endif

# Profiling flags if needed
ifeq (${prof},true)
	CFLAGS += -g -pg
	LFLAGS += -pg
endif

# Basic compilation flags for ARM64
CFLAGS += -std=c++11 -arch arm64 -Wall

# Enable NEON SIMD instructions for ARM64
CFLAGS += -march=armv8-a+simd

# OpenMP flags for Apple's clang
CFLAGS += -Xpreprocessor -fopenmp -I${LIBOMP_DIR}/include

# Add BLAS lib path
ifneq ($(strip ${BLAS_DIR}),)
	LPATHS += -L${BLAS_DIR}
	ifeq (${linking},dynamic)
		LPATHS += -Wl,-rpath,${BLAS_DIR}
	endif
endif

# Add Boost include and lib paths
ifneq ($(strip ${BOOST_INSTALL_DIR}),)
	CPATHS += -I${BOOST_INSTALL_DIR}/include
	LPATHS += -L${BOOST_INSTALL_DIR}/lib
	ifeq (${linking},dynamic)
		LPATHS += -Wl,-rpath,${BOOST_INSTALL_DIR}/lib
	endif
endif

# Add htslib include and lib paths
ifneq ($(strip ${HTSLIB_DIR}),)
	CPATHS += -I${HTSLIB_DIR}/include
	LPATHS += -L${HTSLIB_DIR}/lib
	ifeq (${linking},dynamic)
		LPATHS += -Wl,-rpath,${HTSLIB_DIR}/lib
	endif
endif

# Add OpenMP lib path
LPATHS += -L${LIBOMP_DIR}/lib
ifeq (${linking},dynamic)
	LPATHS += -Wl,-rpath,${LIBOMP_DIR}/lib
endif

# Build link line (minus flags)
LLIBS = -lhts -lboost_program_options -lboost_iostreams -lz ${LBLAS} -lomp
L = ${LPATHS} ${LLIBS} -lpthread -lm

T = eagle
O = DipTreePBWT.o Eagle.o EagleImpMiss.o EagleParams.o EaglePBWT.o FileUtils.o GenoData.o HapHedge.o MapInterpolater.o MemoryUtils.o NumericUtils.o StaticMultimap.o StringUtils.o SyncedVcfData.o Timer.o memcpy.o
OMAIN = EagleMain.o $O

.PHONY: clean all

$T: ${OMAIN}
	${CC} ${LFLAGS} -o $T ${OMAIN} $L

%.o: %.cpp
	${CC} ${CFLAGS} ${CPATHS} -o $@ -c $<

EagleMain.o: Version.hpp
Eagle.o: Version.hpp

all: $T

clean:
	rm -f *.o
	rm -f $T
