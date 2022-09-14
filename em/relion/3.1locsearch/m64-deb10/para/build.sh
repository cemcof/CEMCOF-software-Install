#!/bin/bash

export DIR="/cemcofsw/em/relion/3.1locsearch/m64-deb10/para"

rm -rf $DIR/scripts $DIR/data

(
    cd relion

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

