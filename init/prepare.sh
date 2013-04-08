#!/bin/bash

#if [ ! -f server.tgz ] ; then
#    echo "I'm sorry; we don't have an authoritative source repo to pull from"
#    echo "Instead, if you can provide the 'server.tgz' to work with we can use that"
#    echo "Otherwise, have a nice day."
#    exit 1
#fi

TOPDIR=/home/gt_partha
mkdir -p $TOPDIR
rm -rf $TOPDIR/*

[ -d shaperprobe ] || \
    git clone -b master https://code.google.com/p/shaperprobe/

if [ ! -f $TOPDIR/shaperprobe/daemon.pl ] ; then
    #rm -rf server
    #tar -zxvf server.tgz 
    pushd shaperprobe/shaperprobeserver
        patch -p0 < ../init/probeserver.diff 
        make
        gcc -Wall -o server_select serverSelect.c
        mkdir -p $TOPDIR/shaperprobe
        cp daemon.pl shaperprobeserver $TOPDIR/shaperprobe
        cp server_select $TOPDIR/
    popd
fi

cp -r init $TOPDIR/

tar -C $TOPDIR -cvf gt_partha.tar .

