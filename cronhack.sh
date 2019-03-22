#!/bin/bash
# vague

# cron based automation system using /tmp/ for state
# it just makes sure a script is running at all times. 
# how often it checks is the * * * * * line in cron

#todo
#	make sure we can write the id file before we run the arg
#	options specified in args
#		run once per boot = if $id exists, exit
#			/tmp/ should be ramdisk thats cleared on poweroff
#			we dont delete the id. if its not there it needs to run
# 	cleanup this messy quickly written thing
# 	logging output for debugging
#	write in python for windows

statedir='/tmp/cronhack'
mkdir -p $statedir || { echo cant create statedir ;}

if [ -z "$1" -o -z "$2" ] ; then
	echo usage
	echo need unique id for run
	echo need script to run
	exit
fi

id=$1
script=$2
echo running with id "$id"
echo running with script "$script"

echo check if id is ok
if [ -e "$statedir/$id" ] ; then
	echo unique pid file exists
	echo now check to see if its currently running
	pid=$(cat "$statedir/$id")
	echo found $pid
	if [ -e "/proc/$pid" ] ; then
		echo the script is already running
		exit
	else
		echo the script is not already running
	fi
else
	echo unique pid file doesnt exist
	echo now make it
	echo running script
fi

echo running script $script
$script &
lastid=$!
echo forked. have id $lastid
echo $lastid > $statedir/$id

