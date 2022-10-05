#!/bin/bash

DIR=/cemcofsw/em/modelangelo/0.0.1/x86_64/para

# clean
rm -rf $DIR/*

# conda
./Miniconda3-py39_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s 2>&1 | tee conda.log

# directory for weigths
export TORCH_HOME=$DIR/weights

(
    eval "$($DIR/conda/bin/conda shell.bash hook)"
    cd model-angelo
    bash install_script.sh --download-weights
) 2>&1 | tee model-angelo.log

mkdir $DIR/bin
cp -av model_angelo.tmp $DIR/bin/model_angelo

