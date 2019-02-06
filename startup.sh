#!/bin/bash

# set terminal 
export TERM=vt100

# start cron and update whenever 
service cron start
whenever --update-crontab

# remove PID and start the server
file="/home/tlcdirectory/tmp/pids/server.pid"
[ -f $file ] && rm $file

bin/rails s -p 3000 -b '0.0.0.0'