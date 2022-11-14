#!/bin/bash

DIR=/cemcofsw/em/pytom/1.0/m64-deb10/node

# clean
rm -rf $DIR/*

# conda
./Miniconda3-py38_4.10.3-Linux-x86_64.sh -p $DIR/conda -b -s 2>&1 | tee conda.log

# pytom
(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    cd pytom

    conda env create -f environments/pytom_py3.8_cu10.1.yaml --name pytom_env

    conda activate pytom_env

    python3.8 setup.py install --prefix $DIR/conda/envs/pytom_env
) 2>&1 | tee pytom.log

# Wrappers for pytom
(
    mkdir -p $DIR/bin
    cp -av pytom.tmp $DIR/bin/pytom
    cp -av ipytom.tmp $DIR/bin/ipytom
    cp -av pytomGUI.tmp $DIR/bin/pytomGUI

    for PY in $DIR/conda/envs/pytom_env/bin/*.py; do
        SHEBANG=`head -1 -q $PY`
        if [[ $SHEBANG =~ env[[:blank:]]+pytom ]]; then
            BASE=`basename $PY`

            echo "#!/bin/bash" > $DIR/bin/$BASE
            echo "" >> $DIR/bin/$BASE
            echo "DIR=$DIR" >> $DIR/bin/$BASE
            echo "eval \"\$(\$DIR/conda/bin/conda shell.bash hook)\"" >> $DIR/bin/$BASE
            echo "conda activate pytom_env" >> $DIR/bin/$BASE
            echo "" >> $DIR/bin/$BASE
            echo "$BASE \"\$@\"" >> $DIR/bin/$BASE

            chmod a+x $DIR/bin/$BASE

            echo "$PY -> $DIR/bin/$BASE"
        else
            echo "Skipped: $PY"
        fi
    done

    # mask mpiexec by module activation
    # without including whole conda in PATH
    cp -av mpiexec.tmp $DIR/bin/mpiexec
) 2>&1 | tee pytom_wrappers.log

# pytom hot fixes
(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    conda activate pytom_env

    # own pytom run scripts
    cp -av pytom_conda.tmp $CONDA_PREFIX/lib/python3.8/site-packages/pytom/bin/pytom
    cp -av pytom_conda.tmp $CONDA_PREFIX/bin/pytom

    cp -av ipytom_conda.tmp $CONDA_PREFIX/lib/python3.8/site-packages/pytom/bin/ipytom
    cp -av ipytom_conda.tmp $CONDA_PREFIX/bin/ipytom

    cp -av pytomGUI_conda.tmp $CONDA_PREFIX/lib/python3.8/site-packages/pytom/bin/pytomGUI
    cp -av pytomGUI_conda.tmp $CONDA_PREFIX/bin/pytomGUI

    # own paths.sh file
    cp -av paths.sh.tmp $CONDA_PREFIX/bin/paths.sh
    cp -av paths.sh.tmp $CONDA_PREFIX/lib/python3.8/site-packages/pytom/bin/paths.sh

    # transport angleList into conda
    cp -avr pytom/pytom/angles/angleLists $CONDA_PREFIX/lib/python3.8/site-packages/pytom/angles

    # transport LICENSE.txt into conda
    cp -av pytom/LICENSE.txt $CONDA_PREFIX/lib/python3.8/site-packages/pytom

    # transport pytomc into conda
    cp -avr pytom/pytom/pytomc $CONDA_PREFIX/lib/python3.8/site-packages/pytom

    # transport voltools kernels into conda
    cp -rv pytom/pytom/voltools/kernels $CONDA_PREFIX/lib/python3.8/site-packages/pytom/voltools
) 2>&1 | tee hot_fixes.log
