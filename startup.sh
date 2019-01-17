#!/bin/bash

# set terminal 
export TERM=vt100

# start cron and update whenever 
service cron start
whenever --update-crontab

# remove PID and start the server
file="/home/hydra/tmp/pids/server.pid"
if [ -f $file ] ; then
    rm $file
fi

bin/rails s -p 3000 -b '0.0.0.0'