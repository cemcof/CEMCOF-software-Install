#!/bin/bash

cd ncbi-blast-2.13.0+-src/c++/

module add openmpi/4.1.2/m64-deb10/para

./configure --prefix=/cemcofsw/bioinf/blast+/2.13.0/m64-deb10/para 2>&1 | tee configure.log

make -j8 2>&1 | tee make.log

make install 2>&1 | tee install.log

cp *.log ../..
cd ../..
