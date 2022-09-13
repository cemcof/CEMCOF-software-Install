#!/bin/bash

DIR=/cemcofsw/em/cryodrgn/1.1.0/x86_64/node

# clean
rm -rf $DIR/conda

# install miniconda and setup environment
./Miniconda3-py39_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s
(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    # setup scipion conda environment
    conda create -y --name cryodrgn1 python=3.9
    conda update -y -n base conda
    conda activate cryodrgn1

    conda install -y -c pytorch pytorch
    conda install -y pandas

    conda install -y seaborn scikit-learn
    conda install -y umap-learn jupyterlab ipywidgets cufflinks-py "nodejs>=15.12.0" -c conda-forge
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
    jupyter labextension install jupyterlab-plotly --no-build
    jupyter labextension install plotlywidget --no-build
    jupyter lab build

    cd cryodrgn
    python setup.py install 2>&1 | tee install.log
    mv install.log ..
)

mkdir -p $DIR/bin
cp tmp/cryodrgn $DIR/bin
