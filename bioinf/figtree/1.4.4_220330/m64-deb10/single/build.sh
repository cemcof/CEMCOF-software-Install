#!/bin/bash

DIR=/cemcofsw/bioinf/figtree/1.4.4_220330/m64-deb10/single

mkdir -p $DIR
mkdir -p $DIR/man

# FigTree -------------------------------------------------------
(
    cd figtree
    ant 2>&1 | tee make.log
    cp make.log ..

    cp -r dist lib $DIR
    cp release/common/README.txt $DIR/man
)

# JRE -----------------------------------------------------------
(
    rm -rf $DIR/java
    mkdir $DIR/java
    cp -r jre1.8.0_321/* $DIR/java
)
