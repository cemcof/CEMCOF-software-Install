#!/bin/bash


module add cuda/11.6.1

cd openmpi-4.1.2

export LDFLAGS="-Wl,-rpath=/cemcofsw/devel/openmpi/4.1.2/m64-deb10/para/lib:/cemcofsw/devel/hwloc/2.7.0/m64-deb10/single/lib"

./configure --prefix=/cemcofsw/devel/openmpi/4.1.2/m64-deb10/para --with-hwloc=/cemcofsw/devel/hwloc/2.7.0/m64-deb10/single \
            --with-tm=/usr --with-cma --without-verbs --enable-mpirun-prefix-by-default --enable-mpi-fortran=usempi --enable-mca-no-build=btl-uct \
            --enable-mpi-cxx --with-cuda=/cemcofsw/general/cuda/11.6.1/x86_64/single/targets/x86_64-linux/include 2>&1 | tee configure.log

make -j4 all 2>&1 | tee make.log

make -j4 install 2>&1 | tee install.log

cd ..

cp openmpi-4.1.2/*.log .
