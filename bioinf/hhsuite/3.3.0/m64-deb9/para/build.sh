#!/bin/bash

rm -rf build
mkdir build
cd build

module add openmpi/4.1.2/m64-centos7/para

cmake -DCMAKE_INSTALL_PREFIX=/cemcofsw/bioinf/hhsuite/3.3.0/m64-deb9/para .. 2>&1 | tee configure.log

make 2>&1 | tee make.log

make install 2>&1 | tee install.log
