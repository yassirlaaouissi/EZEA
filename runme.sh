#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
	then 	
	   echo "Please run as root"
	   echo "Usage: sudo ./runme.sh <IP-Address>"
else
	if [ $# -eq 1 ]
  		then
    			dconf load /com/gexperts/Tilix/ < tilix.dconf
			sudo tilix --focus-window --maximize -x "/usr/bin/env bash -c './enum.sh $1'"
	else
        	echo "No arguments supplied"
       		echo "Usage: sudo ./runme.sh <IP-Address>"
	fi
fi



