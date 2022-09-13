#!/bin/bash

rm -rf build
mkdir build
cd build

module add openmpi/4.1.2/m64-centos7/para

cmake -DHAVE_MPI=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/cemcofsw/bioinf/mmseqs2/13-45111/m64-deb9/para .. 2>&1 | tee configure.log

make 2>&1 | tee make.log

make install 2>&1 | tee install.log

