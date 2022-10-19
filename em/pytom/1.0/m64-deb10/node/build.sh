#!/bin/bash

DIR=/cemcofsw/em/pytom/1.0/m64-deb10/node

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

# gnureadline - solves arrow key problems in python shell
(
    eval "$($DIR/conda/bin/conda shell.bash hook)"

    conda activate pytom_env

    pip install gnureadline
) 2>&1 | tee gnureadline.log

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
) 2>&1 | tee pytom_wrappers.log

