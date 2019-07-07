#!/bin/bash

# make sure the scripts is being executed with superuser privileges

if [ "${UID}" -ne 0 ]
then
	echo "Please run with sudo or as root"
exit 1
fi


#get the username
read -p "Enter the username to create: " USER_NAME

#get the real name
read -p "Please enter full name of this user: " COMMENT

#get the password
read -p "Enter the password for this user: " PASSWORD

#create the account
useradd -c "${COMMENT}" -m "${USER_NAME}"

#check to see if the useradd command successed
#we dont want to tell to the user that an account was created when it hasnt been
if [[ "${?}" -ne 0 ]]
then
	echo " The account could not be created "
	exit 1
fi

#set the password
#this is for ubuntu 
echo "${USER_NAME}:${PASSWORD}" | sudo chpasswd

#if you are using redhat you can use --stdin option
#echo ${PASSWD} | passwd --stdin ${USER_NAME}

if [ "${?}" -ne 0 ]
then
	echo " The password for the account could not be set"
	exit 1
fi

#force password change on first login
passwd -e ${USER_NAME}

#Display the username, password and the host name where the user was created

echo
echo "username"
echo "${USER_NAME}"
echo
echo "password"
echo "${PASSWORD}"
echo
echo "host"
echo "$(hostname)"
exit 0
