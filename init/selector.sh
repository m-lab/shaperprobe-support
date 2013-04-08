#!/bin/sh

. /etc/init.d/functions

killall server_select

FIVE_MIN=30;
while [ 1 ];
do
    killall server_select
    nohup /home/gt_partha/server_select 1>/dev/null 2>/dev/null &
    pid=$!;
    while [ 1 ];
    do
        #if [ -z `pgrep -x server_select` ]; then
        status server_select
        ret=$?
        if [ "$ret" -ne 0 ]; then
            break;
        fi
        t=`status server_select | sed 's/.*(pid //'|sed 's/).*//'|sed 's/ /\n/g'|wc -l`
        if [ "$t" -ne 1 ]; then
            break;
        fi
        sleep $FIVE_MIN;
    done
done

