#!/usr/bin/env bash

self_dir=$PWD
build_type=Release

build_dir=$self_dir/.build/$build_type
cache_dir=$self_dir/.cache/$build_type
install_dir=$self_dir/.llvm-root/$build_type

(cd llvm-project \
&& cmake -S llvm -B $build_dir -G Ninja \
    -DCMAKE_BUILD_TYPE=${build_type} \
    -DCMAKE_INSTALL_PREFIX=$install_dir \
    -DLLVM_CCACHE_BUILD=ON \
    -DLLVM_CCACHE_DIR=$cache_dir \
    -DLLVM_ENABLE_PROJECTS='llvm;mlir;clang' \
    -DLLVM_TARGETS_TO_BUILD='all' \
    -DLLVM_INSTALL_UTILS=ON \
    -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
    -DPython3_EXECUTABLE="$(which python3)" \
&& cmake --build $build_dir -j 12 \
&& cmake --install $build_dir)

rm -rf $self_dir/llvm-root
ln -sf $install_dir $self_dir/llvm-root

