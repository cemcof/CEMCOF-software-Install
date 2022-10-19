#!/bin/bash

DIR=/cemcofsw/em/pytom/1.0/x86_64/node

# clean
rm -rf $DIR/*

# conda
./Miniconda3-py39_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s 2>&1 | tee conda.log

# pytom
(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    cd pytom

    conda env create -f environments/pytom_py3.8_cu10.1.yaml --name pytom_env

    conda activate pytom_env

    python3.8 setup.py install --prefix $DIR/conda/envs/pytom_env
) 2>&1 | tee pytom.log

mkdir -p $DIR/bin
cp -av pytom.tmp $DIR/bin/pytom
cp -av ipytom.tmp $DIR/bin/ipytom
cp -av pytomGUI.tmp $DIR/bin/pytomGUI

