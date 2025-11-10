#!/bin/bash
getent group developers | | groupadd developers
	grep -v -e "^#" /root/userlist.txt | while read line
	do
	    if id -u "$line" >/dev/null 2>&1; then
	        echo 'User already exists'
	    else
	        useradd $line
	        echo TempPass123 | passwd --stdin $line
	        usermod -aG developers $line
	        echo "Welcome to the system" > /home/$line/welcome.txt 
	    fi
	done < /root/userlist.txt
	exit
