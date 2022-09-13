#!/bin/bash

DIR=/cemcofsw/bioinf/trimal/1.4.1_220323/m64-deb10/single

rm -rf $DIR/conda
rm -rf $DIR/scripts
rm -rf $DIR/dataset

cd trimal/source/

make clean
make 2>&1 | tee make.log

cp readal statal trimal $DIR/bin

cp *.log ../..

cd ..

cp -r dataset $DIR
cp -r scripts $DIR

cd ..

./Miniconda3-py38_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s

(
eval "$($DIR/conda/bin/conda shell.bash hook)"

conda create -y -n py27 python=2.7 biopython numpy
conda create -y -n py38 python=3.8 biopython numpy
)

cd $DIR/scripts 
sed -i 's+#!/usr/bin/python3+#!/cemcofsw/bioinf/trimal/1.4.1_220323/m64-deb10/single/conda/envs/py38/bin/python+g' *.py
sed -i 's+#!/usr/bin/python+#!/cemcofsw/bioinf/trimal/1.4.1_220323/m64-deb10/single/conda/envs/py38/bin/python+g' generateRandomAlignmentsUsingAsSeedRealAlignments.py
sed -i 's+#!/usr/bin/python+#!/cemcofsw/bioinf/trimal/1.4.1_220323/m64-deb10/single/conda/envs/py27/bin/python+g' *.py

