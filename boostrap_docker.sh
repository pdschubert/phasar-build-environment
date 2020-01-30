#!/bin/bash
set -e

NUM_THREADS=$(nproc)
LLVM_RELEASE=llvmorg-9.0.0
Z3_RELEASE=z3-4.8.7

./utils/InitializeEnvironment.sh
./utils/InstallAptDependencies.sh

sudo pip install Pygments
sudo pip install pyyaml

# installing boost
sudo apt-get install libboost-all-dev -y

# installing LLVM
./utils/install-llvm.sh $NUM_THREADS . $LLVM_RELEASE
# installing z3
./utils/install-z3.sh $NUM_THREADS . $Z3_RELEASE
# installing wllvm
sudo pip3 install wllvm

echo "dependencies successfully installed"

export CC=/usr/local/bin/clang
export CXX=/usr/local/bin/clang++
