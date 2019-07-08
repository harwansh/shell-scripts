#!/bin/bash

#this script deletes a user
#run as root.

if [ "${UID}" -ne 0 ]
then
	echo "Please run with sudo or as root" >&2
	exit 1
fi

#assume the first argument is the user to delete.
read -p "please enter username which you want to delete: " USER

#make sure the uid of the account is at least 1000

USERID=$(id -u ${USER})

if [ "${USERID}" -lt 1000 ]
then
	echo " Refusing to resmove the ${USER} account with UID ${USERID}" >&2
	exit 1
fi

#Ask for creating acrhive home dir
read -p "Do you want to archive ${USER} home dir?(y/n)" ANSWER
case "$ANSWER" in
	"y") if [ -d "/home/${USER}" ]
	then 
		echo "creating archive dir"
		tar -czvf /home/Archive/${USER}_archive.tar.gz /home/${USER}
		
	else 
	
		echo "Home dir for ${USER} is not present"
	fi
        ;;

        "n") echo "Archive dir will not create for ${USER}"
         ;;
esac
#delete the user
userdel -r ${USER}

#make sure the user got deleted

if [ "$?" -ne 0 ]
then
	echo "the account ${USER} was not deleted ">&2
	exit 1
fi

#tell the user the account was deleted.
echo "the account ${USER} was deleted."
exit 0
