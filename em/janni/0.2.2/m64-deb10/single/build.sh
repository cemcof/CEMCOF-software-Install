#!/bin/bash

DIR="/cemcofsw/em/janni/0.2.2/m64-deb10/single"

rm -rf $DIR/conda

./Miniconda3-py38_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s

(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    conda create -y -n janni -c anaconda \
          python=3.6 cudnn=7.1.2 libtiff wxPython=4.0.4 numpy==1.14.5

    conda activate janni

    pip --no-cache-dir install tensorflow==1.12.0
    pip --no-cache-dir install tensorflow-gpu=1.12.0
    pip --no-cache-dir install cython==0.29.5
    pip --no-cache-dir install imagecodecs-lite==2019.2.22
    pip --no-cache-dir install janni-0.2.2.tar.gz
)

