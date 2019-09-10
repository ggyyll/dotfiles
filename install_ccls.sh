#!/bin/bash
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls 
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release

# 将 ccls 添加到环境变量
cd Release
ln -sf `pwd`/ccls $HOME/bin/ccls


