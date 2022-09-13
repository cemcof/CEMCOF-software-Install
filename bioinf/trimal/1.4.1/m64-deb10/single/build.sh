#!/bin/bash

DIR=/cemcofsw/bioinf/trimal/1.4.1/m64-deb10/single

cd trimal-1.4.1/source/

make clean
make 2>&1 | tee make.log

cp readal statal trimal $DIR/bin

cp *.log ../..

cd ..

cp -r dataset $DIR

cd ..

