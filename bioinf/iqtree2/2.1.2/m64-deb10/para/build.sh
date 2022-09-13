#!/bin/bash

cd iqtree2-2.1.2

# NON-MPI build
(
    rm -rf build
    mkdir build
    cd build

    cmake -DCMAKE_INSTALL_PREFIX=/cemcofsw/bioinf/iqtree2/2.1.2/m64-deb10/para .. 2>&1 | tee configure.log

    make -j4 2>&1 | tee make.log

    make install 2>&1 | tee install.log

    cp *.log ../..
)

# MPI build ---------------------------------------------------------------------------------------------------------------------
(
    module add openmpi/4.1.2/m64-deb10/para

    rm -rf build-mpi
    mkdir build-mpi
    cd build-mpi

    cmake -DIQTREE_FLAGS=mpi -DCMAKE_INSTALL_PREFIX=/cemcofsw/bioinf/iqtree2/2.1.2/m64-deb10/para .. 2>&1 | tee configure-mpi.log

    make -j4 2>&1 | tee make-mpi.log

    make install 2>&1 | tee install-mpi.log

    cp *.log ../..
)

