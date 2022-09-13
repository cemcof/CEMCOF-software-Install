#!/bin/bash

DIR="/cemcofsw/em/locscale/2.0/x86_64/para"

rm -rf $DIR/*

# Conda ------------------------------------------------------------------
./Miniconda3-py38_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s
(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    module add ccp4/8.0.001

    conda create -y -n locscale python=3.8

    conda activate locscale

    conda install -y -c conda-forge gfortran

    pip install locscale

) 2>&1 | tee conda.log

