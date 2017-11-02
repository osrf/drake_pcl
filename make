#!/bin/bash

DRAKE_CMAKE_PATH="${DRAKE_CMAKE_PATH:-/opt/drake/lib/cmake}"
basedir=".."
cmaketrace_path="${basedir}/cmake.trace"

test -d build && rm -rf build
mkdir build
#cd build && cmake -DCMAKE_SYSTEM_PREFIX_PATH=/opt/drake .. && make -j5
cd build && cmake \
	--trace-expand \
	-DUSE_DRAKE_EIGEN=1 \
	-Ddrake_DIR="$DRAKE_CMAKE_PATH" \
	-DPCL_DIR="$(pwd)/${basedir}/pcl" \
	"$basedir" 2> "$cmaketrace_path"
test $? -eq 0 && make -j5

cd "$basedir"

