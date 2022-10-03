#!/bin/bash

DIR=/cemcofsw/general/ffmpeg/5.1.2/m64-deb10/single

(
    cd ffmpeg-5.1.2

    ./configure --prefix=$DIR 2>&1 | tee configure.log

    make -j 4 2>&1 | tee compile.log

    make install 2>&1 | tee install.log
)
