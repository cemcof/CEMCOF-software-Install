#!/bin/bash

DIR="/cemcofsw/em/fourier3d/1.0/m64-deb10/single"
rm -rf $DIR/bin/*

(
    cd Fourier3D-1.0
    make clean
    make 2>&1 | tee make.log

    cp Fourier3D $DIR/bin    
    cp *.log ..
)

(
    cd $DIR/bin
    ln -s Fourier3D fourier3d
)

