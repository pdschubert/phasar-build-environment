#!/bin/bash

set -e

num_cores=1
target_dir=./
re_number="^[0-9]+$"
re_z3_release="^z3-[0-9]+\.[0-9]+\.[0-9]+$"

if [ "$#" -ne 3 ] || ! [[ "$1" =~ ${re_number} ]] || ! [ -d "$2" ] || ! [[ "$3" =~ ${re_z3_release} ]]; then
	echo "usage: <prog> <# cores> <directory> <z3 release (e.g. 'z3-4.8.7')>" >&2
	exit 1
fi

num_cores=$1
target_dir=$2
z3_release=$3

echo "Getting the Z3 source code..."
if [ ! -d "${target_dir}/z3" ]; then
    echo "Getting the complete z3 source code"
	git clone https://github.com/Z3Prover/z3.git ${target_dir}/z3
fi
echo "Building z3..."
cd ${target_dir}/z3/
echo "Build the z3 project"
git checkout ${z3_release}
mkdir -p build
cd build
cmake -G "Unix Makefiles" ..
make -j${num_cores}
# echo "Run all tests"
# make -j3 check-all
echo "Installing z3..."
sudo make install
sudo ldconfig
cd ../..
echo "Installed z3 successfully."
