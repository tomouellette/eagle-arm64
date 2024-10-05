# Eagle

This repository modifies the [`eagle`](https://alkesgroup.broadinstitute.org/Eagle/) phasing software and compilation instructions to allow for compilation of a binary on apple `arm64` architectures. The modifications were made to allow for running [`numbat`](https://github.com/kharchenkolab/numbat) single-cell copy number analysis on apple `M` series machines outside of docker.

## Setup

It is assumed you are attempting to build `eagle` on an apple `arm64` machine. If you are on an x86 linux, then you can use the original pre-built binarires from the [`eagle`](https://alkesgroup.broadinstitute.org/Eagle/) website.

For simplicity, compilation is linked against `homebrew` installed libraries.

```bash
brew install boost openblas libomp htslib zlib
```

Then, clone the repository and compile the binary.

```bash
git clone https://github.com/tomouellette/eagle-macos-arm64
cd eagle-macos-arm64
make    
```

## References

1. Source code: https://github.com/poruloh/Eagle
2. Documentation: http://data.broadinstitute.org/alkesgroup/Eagle/
# eagle-arm64
