#!/bin/bash

if [ -z "$SOURCE_DIR" ] ; then
    echo "Expected SOURCE_DIR in environment"
    exit 1
fi
if [ -z "$BUILD_DIR" ] ; then
    echo "Expected BIULD_DIR in environment"
    exit 1
fi

if test -d $BUILD_DIR ; then
    rm -rf $BUILD_DIR/*
fi

pushd $SOURCE_DIR/shaperprobe/shaperprobeserver
    patch -p0 < $SOURCE_DIR/init/probeserver.diff 
    make
    gcc -Wall -o server_select serverSelect.c
    mkdir -p $BUILD_DIR/shaperprobe
    cp daemon.pl shaperprobeserver $BUILD_DIR/shaperprobe
    cp server_select $BUILD_DIR/
popd

cp -r init $BUILD_DIR/
