#!/bin/bash

DIR=/cemcofsw/em/resmap/1.1.4/x86_64/single

rm -rf $DIR/conda
rm -rf $DIR/libexec
mkdir $DIR/libexec

./Miniconda3-py38_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s

(
eval "$($DIR/conda/bin/conda shell.bash hook)"

conda create -y -n py27 python=2.7 numpy=1.9.3 scipy=0.19.1 matplotlib=2.0.2
)

rm -rf src
mkdir src
cp ResMap-1.1.4-src.zip src
cd src
unzip ResMap-1.1.4-src.zip
cp -v *.py $DIR/libexec
cd ..
rm -rf src
