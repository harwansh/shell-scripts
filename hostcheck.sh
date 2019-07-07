#!/bin/bash 
read -p "Please enter host name: " HOST_NAME
ping -c 2 $HOST_NAME
if [ "$?" -eq 0 ]
then
	echo "$HOST_NAME is reachable"
else
	echo "$HOST_NAME is unreachable"
fi
