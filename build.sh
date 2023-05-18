#!/usr/bin/env bash

INSTALL_DIR=${INSTALL_DIR:-$PWD/llvm-root}
CACHE_DIR=${CACHE_DIR:-$PWD/.cache}

build_type=Release

(cd llvm-project \
&& cmake -S llvm -B build -G Ninja \
    -DCMAKE_BUILD_TYPE="${build_type}" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DLLVM_CCACHE_BUILD=ON \
    -DLLVM_CCACHE_DIR="$CACHE_DIR" \
    -DLLVM_ENABLE_PROJECTS='llvm;mlir;clang;clang-tools-extra' \
    -DLLVM_TARGETS_TO_BUILD='all' \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_BUILD_EXAMPLES=ON \
    -DCLANG_BUILD_EXAMPLES=ON \
    && cmake --build build -j "$(nproc)" \
    && cmake --install build)

