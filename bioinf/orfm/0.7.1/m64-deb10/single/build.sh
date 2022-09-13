#!/bin/bash

(
    cd orfm-0.7.1

    ./configure --prefix=/cemcofsw/bioinf/orfm/0.7.1/m64-deb10/single 2>&1 | tee configure.log

    make 2>&1 | tee make.log

    make install 2>&1 | tee install.log

    cp *.log ..
)
