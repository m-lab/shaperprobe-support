#!/bin/bash

source /etc/mlab/slicectrl-functions

cd $SLICEHOME/shaperprobe/
perl $SLICEHOME/shaperprobe/daemon.pl &> /dev/null &

if [[ $(hostname) =~ "nuq0t" ]]; then
    cd $SLICEHOME
    $SLICEHOME/init/selector.sh &> /dev/null &
fi
