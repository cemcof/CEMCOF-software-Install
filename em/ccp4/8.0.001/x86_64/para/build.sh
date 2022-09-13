#!/bin/bash

DIR="/cemcofsw/em/ccp4/8.0.001/x86_64/para"
HOMEDIR=${PWD}

rm -rf $DIR/*

# We are installing without arp/warp for now
mv arp_warp_8.0 arp_warp_8.0_NOTINCLUDED

(
    #cp -r arp_warp_8.0 $DIR/
    cp -r ccp4-8.0 $DIR/
    cd $DIR/ccp4-8.0
    ./BINARY.setup 2>&1 | tee configure.log
    mv configure.log $HOMEDIR
)
