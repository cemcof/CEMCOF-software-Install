#!/bin/bash

cd mafft-7.490-with-extensions/core
make clean
make 2>&1 | tee make_core.log
make install 2>&1 | tee install_core.log

cp *.log ../..

cd ../extensions
make clean
make 2>&1 | tee make_extensions.log
make install 2>&1 | tee install_extensions.log

cp *.log ../..

cd ../..
