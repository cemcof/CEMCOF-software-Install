#!/bin/bash

DIR=/cemcofsw/em/phenix/1.20.1/x86_64/para

rm -rf $DIR/*
(
    cd phenix-installer-1.20.1-4487-intel-linux-2.6-x86_64-centos6
    ./install --prefix=$DIR 2>&1 | tee install.log

    cp *.log ..
)
