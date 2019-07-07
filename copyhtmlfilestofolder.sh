#!/bin/bash

#it will to source dir
cd /var/www

if [ "$?" -ne 0 ]
then
	echo "source dir not found, please give correct dir"
	exit 1
else

for file in *.html
do
	echo "copying $file"
	#we are coping files to dest dir
	cp $file /home/wansh/shell-scripts/htmlfiles
done
fi
exit 0

