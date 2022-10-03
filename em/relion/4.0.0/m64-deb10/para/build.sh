#!/bin/bash

export DIR="/cemcofsw/em/relion/4.0.0/m64-deb10/para"

rm -rf $DIR/scripts $DIR/data

rm -rf relion-4.0.0

tar xvf 4.0.0.tar.gz

patch relion-4.0.0/CMakeLists.txt < cmake.patch 

(
    cd relion-4.0.0

    rm -rf build
    mkdir build
    (
        cd build

        module add cuda/11.6.1
        module add openmpi/4.1.2/m64-deb10

        cmake -DCMAKE_INSTALL_PREFIX=$DIR -DCUDA=ON -DCUDA_ARCH="--gpu-architecture=compute_50 --gpu-code=compute_50,sm_75,sm_86" .. 2>&1 | tee configure.log

        make -j4 2>&1 | tee make.log

        make install 2>&1 | tee install.log

        cp *.log ../..
    )

    cp -r scripts data $DIR
)

