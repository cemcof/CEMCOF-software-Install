#!/bin/bash

VER=2.2.4
DIR=/cemcofsw/bioinf/alphafold/$VER/x86_64/node

# clean
rm -rf $DIR/bin
rm -rf $DIR/conda
rm -rf $DIR/src
rm -rf alphafold-$VER*

# install miniconda and setup environment
./Miniconda3-py38_4.9.2-Linux-x86_64.sh -p $DIR/conda -b -s
eval "$($DIR/conda/bin/conda shell.bash hook)"

# setup alphafold conda environment
conda create -y --name alphafold python==3.8
conda update -y -n base conda
conda activate alphafold

conda install -y -c conda-forge openmm==7.5.1 cudnn cudatoolkit==11.7.0 pdbfixer==1.7
conda install -y -c bioconda hmmer==3.3.2 hhsuite==3.3.0 kalign2==2.04

# alphafold setup
tar -xzvf v$VER.tar.gz --directory $DIR/

pip install --no-cache-dir absl-py==0.13.0 biopython==1.79 chex==0.0.7 dm-haiku==0.0.4 dm-tree==0.1.6 immutabledict==2.0.0 jax==0.2.14 ml-collections==0.1.0 
pip install --no-cache-dir numpy scipy tensorflow==2.9.0 pandas tensorflow-cpu==2.9.0
pip install --no-cache-dir --upgrade "jax[cuda]" jaxlib -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
pip install --no-cache-dir -r $DIR/alphafold-$VER/requirements.txt

# tune alphafold
wget -q -P $DIR/alphafold-$VER/alphafold/common/ https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt
(
    cd $DIR/conda/envs/alphafold/lib/python3.8/site-packages/
    patch -p0 < $DIR/alphafold-$VER/docker/openmm.patch
)

# bash wrapper
mkdir $DIR/bin
cp -a alphafold.tmp $DIR/bin/alphafold

# prepare for patching
cp -r $DIR/alphafold-$VER $DIR/alphafold-$VER-orig
cp diff_me $DIR/

echo "MANUAL PATCHING of utils.py, jackhammer.py and hhlibs.py NEEDED"
echo "to make alphafold respect number of NCPUS in jackhammer and hhlibs"
echo
echo "Changes can be displayed with script diff_me in $DIR"

