#!/bin/bash

DIR=/cemcofsw/em/eman/dev/x86_64/para

rm -rf $DIR/*

./eman2_sphire_sparx_huge.linux.unstable.sh -b -f -p $DIR 2>&1 | tee install.log
