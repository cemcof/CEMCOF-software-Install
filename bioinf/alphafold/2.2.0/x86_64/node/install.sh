#!/bin/bash

DIR=/cemcofsw/bioinf/alphafold/2.2.0/x86_64/node

# clean
rm -rf $DIR/conda
rm -rf $DIR/src

# install cuda toolkit and setup environment
module add cudacdk/11.2.2

# install miniconda and setup environment
./Miniconda3-py38_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s
eval "$($DIR/conda/bin/conda shell.bash hook)"

# setup alphafold conda environment
conda create --name alphafold python==3.8
conda update -y -n base conda
conda activate alphafold

conda install -y -c conda-forge openmm==7.5.1 cudnn==8.2.1.32 cudatoolkit==11.2.2 pdbfixer==1.7
conda install -y -c bioconda hmmer==3.3.2 hhsuite==3.3.0 kalign2==2.04

# alphafold setup

tar -xzvf v2.2.0.tar.gz --directory $DIR/

pip install absl-py==0.13.0 biopython==1.79 chex==0.0.7 dm-haiku==0.0.4 dm-tree==0.1.6 immutabledict==2.0.0 jax==0.2.14 ml-collections==0.1.0 numpy==1.19.5 scipy==1.7.0 tensorflow==2.5.0
pip install --upgrade jax jaxlib==0.1.69+cuda111 -f https://storage.googleapis.com/jax-releases/jax_releases.html
pip install -r $DIR/alphafold-2.2.0/requirements.txt

# tune alphafold
wget -q -P $DIR/alphafold-2.2.0/alphafold/common/ https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt
(
    cd $DIR/conda/envs/alphafold/lib/python3.8/site-packages/
    patch -p0 < $DIR/alphafold-2.2.0/docker/openmm.patch
)

