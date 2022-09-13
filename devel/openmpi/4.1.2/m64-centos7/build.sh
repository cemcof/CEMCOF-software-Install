#!/bin/bash

export LDFLAGS="-Wl,-rpath=/cemcofsw/devel/openmpi/4.1.2/m64-centos7/para/lib:/cemcofsw/devel/hwloc/2.7.0/m64-centos7/single/lib"

./configure --prefix=/cemcofsw/devel/openmpi/4.1.2/m64-centos7/para --with-hwloc=/cemcofsw/devel/hwloc/2.7.0/m64-centos7/single \
            --with-tm=/opt/pbs --with-cma --without-verbs --enable-mpirun-prefix-by-default --enable-mpi-fortran=usempi --enable-mca-no-build=btl-uct 2>&1 | tee configure.log

make -j4 all 2>&1 | tee make.log

make -j4 install 2>&1 | tee install.log

