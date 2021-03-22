#Author: 4UT0M4T0N, 2020
#This program is free software: you can redistribute it and/or modify it under the terms of version 2 of the GNU General Public License as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.  For a copy of the GNU General Public License, see <https://www.gnu.org/licenses/>.

#!/bin/bash

NONE='\e[00m'
RED='\e[01;31m'
GREEN='\e[01;32m'
YELLOW='\e[01;33m'
PURPLE='\e[01;35m'
CYAN='\e[01;36m'
WHITE='\e[01;37m'
GRAY='\e[01;90m'
BOLD='\e[1m'
UNDERLINE='\e[4m'
lb="\n*********************************************************************\n"

change=1
nmap=2
dir_http=3
dir_https=4
smb=5
nikto=6
smtp=7
snmp=8
add=9
delete=10
help=11
coffee=12
close=13
declare -a custom_commands

BANNER="${YELLOW}
          _                                        
  \      | |                              _         
 _____   | | _____     ____ _____  ____ _| |_ _____ 
(____ |  | |(____ |   / ___|____ |/ ___|_   _) ___ |
/ ___ |  | |/ ___ |  ( (___/ ___ | |     | |_| ____|
\ ____|   \_)_____|   \____)_____|_|      \__)_____)
${GRAY}Author: 4UT0M4T0N${NONE}\n"


                                                                                                                                                                                                          
help() {
	echo -e "${GREEN}\n$lb\nA la carte v0.1\nAuthor: 4UT0M4T0N\nComments or suggestions? Find me on Twitter (@4UT0M4T0N) or Discord (#1276).  Trolls > /dev/null\n\nThis tool helps automate repetitive initial enumeration steps.  Some of the most common functions are included as default options, but you can also add your own custom commands which will be saved across sessions.\n\nUSAGE\n./alacarte.sh [target][:port] [command]\n\nTARGET\nIPv4 address (can include sub-dirs)\n\nCOMMAND\nnmap - Quick TCP, Quick UDP (requires sudo), Full TCP, and Vuln scans\ndir_http - Runs dirsearch, dirb, and gobuster against HTTP\ndir_https - Runs dirsearch, dirb, and gobuster against HTTPS\nsmb - Runs enum4linux, nbtscan, nmap enum/vuln scans, and smbclient\nnikto - well...nikto\nsmtp - Enumerates username list against port 25; requires smtp_enum.py and username list\nsnmp - Runs OneSixtyOne and snmpwalk\n\nEXAMPLES\n./alacarte.sh\n./alacarte.sh 192.168.1.5 -- sets target IP\n./alacarte.sh 192.168.1.5/supersecretfolder -- sets target IP (including sub-directory)\n./alacarte.sh 192.168.1.5:443 -- sets target IP and port\n./alacarte.sh 192.168.1.5 nmap -- sets target IP and kicks off nmap\n./alacarte.sh 192.168.1.5:443 nmap -- sets IP, port, and kicks of command\n$lb${NONE}"
menu

}
#validate IP address format
ip_check() {
	if [[ $targetIP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]; then
		return 1
	else
		return 0
	fi
}

#check for requested module and execute
call_option() {
	while true
	do 
		ip_check

		#if running module that doesn't require IP address
		if [ $? == 1 ] || [ $choice == 1 ] || [ $choice == 9 ] || [ $choice == 10 ] || [ $choice == 11 ] || [ $choice == 12 ] || [ $choice == 13 ]; then
			break
	
		#otherwise loop until valid IP is entered	
		else	
			while true
			do
				read -p "Enter target[:port]: " targetIP
				ip_check
				if [ $? == 1 ]; then
					break
				else
					echo "Bad IP address. Try again: "
				fi
			done
		fi
	done
	case $choice in
		#change target
		$change)
			while true
			do
				read -p "Enter target[:port]: " targetIP
				ip_check
				if [ $? == 0 ]; then
					read -p "Bad IP Address.  Try again: " targetIP
				else	
					break
				fi
			done
			echo
			;;


		#nmap
		$nmap|"nmap")

			echo -e "${GREEN}${BOLD}===== Running Quick Nmap TCP CONNECT scan ======${NONE}"
			cmd="nmap -sT -Pn --top-ports 100 -T4 --reason -v $targetIP"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			
			echo -e "${GREEN}${BOLD}===== Running Nmap UDP scan ======${NONE}"
			cmd="nmap -sU -Pn --top-ports 100 -T4 -v $targetIP"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			
			echo -e "${GREEN}${BOLD}===== Running Full Nmap TCP CONNECT scan ======${NONE}"
			cmd="nmap -sT -Pn -A -p- -T4 -v $targetIP"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			
			echo -e "${GREEN}${BOLD}===== Running Full Nmap vuln scan ======${NONE}"
			cmd="nmap -sT -Pn -A --script vuln -p- -T4 -v $targetIP"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			;;
				
		#dir enum
		$dir_http|"dir_http")
			echo -e "${GREEN}${BOLD}===== Running dirsearch =====${NONE}\n"
			cmd="python3 $(locate -b "dirsearch.py" | head -n 1) -R 3 -u http://$targetIP -e php,txt,html,asp"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
		
			echo -e "${GREEN}${BOLD}===== Running Gobuster =====${NONE}\n"
			cmd="gobuster dir -u http://$targetIP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			
			echo -e "${GREEN}${BOLD}===== Running Dirb =====${NONE}\n"
			cmd="dirb http://$targetIP /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -w"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			;;
		
		#HTTPS
		$dir_https|"dir_https")
			echo -e "${GREEN}${BOLD}===== Running dirsearch =====${NONE}\n"
			cmd="python3 $(find / -name "dirsearch.py" -type f 2>/dev/null -print -quit) -u https://$targetIP -e php,txt,html,asp"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
		
			echo -e "${GREEN}${BOLD}===== Running Gobuster =====${NONE}\n"
			cmd="gobuster dir -u https://$targetIP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
		

			echo -e "${GREEN}${BOLD}===== Running Dirb =====${NONE}\n"
			cmd="dirb https://$targetIP /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -w"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			;;
		
		#SMB
		$smb|"smb")

                        echo -e "${GREEN}${BOLD}===== Running nbtscan =====${NONE}\n"
			cmd="nbtscan -r $targetIP"
                        echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			printf '\n'

                        echo -e "${GREEN}${BOLD}===== Running nmap smb-os-discovery =====${NONE}\n"
                        cmd="nmap -Pn -v -p 139,445 --script=smb-os-discovery $targetIP"
                        echo -e "${RED}${BOLD}$cmd\n${NONE}"
                        $cmd
                        printf '\n'
			
			echo -e "${GREEN}${BOLD}===== Running nmap smb-protocols =====${NONE}\n"
                        cmd="nmap -Pn -v -p139,445 --script=smb-protocols $targetIP"
                        echo -e "${RED}${BOLD}$cmd\n${NONE}"
                        $cmd
                        printf '\n'


                        echo -e "${GREEN}${BOLD}===== Running nmap smb vuln scripts =====${NONE}\n"
                        cmd="nmap -Pn -v -p 139,445 --script=smb-vuln* $targetIP"
                        echo -e "${RED}${BOLD}$cmd\n${NONE}"
                        $cmd
                        printf '\n'

			echo -e "${GREEN}${BOLD}===== Running nmap smb enum scripts =====${NONE}\n"
			cmd="nmap -Pn -p 139,445 --script=smb-enum* $targetIP"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			printf '\n'

			echo -e "${GREEN}${BOLD}===== Enumerating host with smbmap =====\n${NONE}"
			cmd="smbmap -H $targetIP"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
			
			#testing anonymous login and attempting to list shares
			echo -e "${GREEN}${BOLD}===== Listing shares with smbclient =====${NONE}\n"
			cmd="smbclient -L //$targetIP -N"
			echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			echo ""
                        
			echo -e "${GREEN}${BOLD}===== Running enum4linux =====${NONE}\n"
			cmd="enum4linux -a $targetIP"
                        echo -e "${RED}${BOLD}$cmd\n${NONE}"
			$cmd
			printf '\n'
			;; 
		#Nikto
		$nikto|"nikto")
			echo -e "${GREEN}${BOLD}===== Running Nikto query =====${NONE}\n"
			cmd="nikto -host $targetIP -port 80 -maxtime=60s -C all"
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""
			
			cmd="nikto -host $targetIP -port 443 -maxtime=60s -C all"
			echo -e "${RED}${BOLD}$cmd${NONE}"
			$cmd
			;;	
	
		#SMTP
		$smtp|"smtp")	
			#echo -n "Filename containing usernames: "
			#file=$2
			#read file
			echo -e "${GREEN}${BOLD}===== Enumerating SMTP =====${NONE}\n"
			cmd="sudo python resources/smtp_enum.py $targetIP resources/users.txt"
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""
			;;	

		#SNMP
		$snmp|"snmp")
			
			echo -e "${GREEN}${BOLD}===== Onesixtyone =====${NONE}\n"
			
			cmd="onesixtyone -c resources/snmp_communities $targetIP"
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""		
	
		#	echo -e "${GREEN}${BOLD}===== snmp-check =====${NONE}\n"
		#	cmd="snmp-check $targetIP -c Public | tee ./Recon/SNMP/snmp-check-results_$targetIP.results"
		#	echo -e "${RED}${BOLD}$cmd${NONE}\n"
		#	$cmd
		#	echo ""

			echo -e "${GREEN}${BOLD}===== snmpwalk users =====${NONE}\n"
			cmd="snmpwalk -c public -v1 $targetIP 1.3.6.1.4.1.77.1.2.25"       	
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""

			echo -e "${GREEN}${BOLD}===== snmpwalk running processes =====${NONE}\n"
			cmd="snmpwalk -c public -v1 $targetIP 1.3.6.1.2.1.25.4.2.1.2"       	
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""

			echo -e "${GREEN}${BOLD}===== snmpwalk installed software =====${NONE}\n"
			cmd="snmpwalk -c public -v1 $targetIP 1.3.6.1.2.1.25.6.3.1.2"       	
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""

			echo -e "${GREEN}${BOLD}===== snmpwalk all=====${NONE}\n"
			cmd="snmpwalk -c public -v1 $targetIP"
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""
			;;		
		
		$add|"add")
			read -p "Type the command to add. Use 'target' as an IP placeholder (i.e ping target): " new_command
			#len=${#list[@]}
			echo "$new_command" >> "$custom_file"
			if [ $loaded -eq 1 ]; then
				list+=( "$new_command" )
			fi
			;;
		$delete|"delete")
			if [ -s alacarte.txt ]; then
				read -p "Enter the command number you'd like to delete: " num
			else
				echo -e "Error: There are no custom commands saved.\n"
				menu
			fi	
			if [ $num -lt 14 ] || [ $num -gt ${#list[@]} ] || ! [[ $num =~ ^[0-9]+ ]]; then
				echo "Invalid selection.  Please try again."
		      		call_option
			else		
				i=$((num-1))
				cmd=${list[$i]}
				echo -ne "Are you sure you want to delete ${RED}$cmd${NONE} [y/N]?"
			       	read a	
				if [ "$a" == "y" ] || [ "$a" == "Y" ]; then
					echo Deleting $cmd
					#unset list[$i]
					list=( "${list[@]:0:$i}" "${list[@]:$num}" )

					#remove from alacarte.txt
					sed -e s/"$cmd"//g -i alacarte.txt
					sed '/^$/d' -i alacarte.txt
				fi 
			fi
			;;

		$help)
			help
			;;
		$coffee)
			echo -e "${YELLOW}${BOLD}coffee${NONE}"
			sleep 1s
			echo -e "${YELLOW}${BOLD}pwn${NONE}"
			sleep 1s
			echo -e "${YELLOW}${BOLD}repeat${NONE}\n"
			sleep 1s
			;;
		$close|"exit")
			echo -e "${YELLOW}${BOLD}Thanks for playing.${NONE}\n"
			exit 0
			;;
		
		#will run saved custom command exactly as written	
		*)
			echo -e "${GREEN}${BOLD}===== Running Custom Command  =====${NONE}\n"
			cmd="${list[(($choice-1))]}"
			cmd="${cmd//target/$targetIP}"
			echo -e "${RED}${BOLD}$cmd${NONE}\n"
			$cmd
			echo ""
			;;
	esac
	echo	
}

#menu items
list=("Change target" "nmap" "Directory enumeration (HTTP)" "Directory enumeration (HTTPS)" "SMB enumeration" "Nikto scan" "SMTP user scan" "SNMP enumeration" "Add a custom command" "Delete a custom command" "Help" "Out of ideas..." "Exit")

#main menu
menu () {
	echo -e "\n\n"
	ip_check

	#if user entered IP as arg during initial launch
	if [ $? == 1 ]; then
		echo -e "Current target: ${RED}$targetIP${NONE}"
	else
		echo -e "Current target: ${RED}Not set${NONE}"
	fi

	echo -e "\n${UNDERLINE}DEFAULT COMMANDS${NONE}"
	
	#print the 13 standard menu options
	for i in {0..12};
	do
		echo \($(($i+1))\) ${list[$i]}
	done

	#if present and not already loaded into array, read in saved custom commands from alacarte.txt
	if [[ $loaded -eq 0 && -s "$custom_file" ]]; then
		loaded=1
		readarray -t tmp < $custom_file
		list+=("${tmp[@]}")
	fi

		echo -e "\n${UNDERLINE}CUSTOM COMMANDS${NONE}"
	
	#and print them as menu options
	if [ -s alacarte.txt ]; then
		len=${#list[@]}
		for j in $(seq 13 $((len-1)));
		do
			echo \($(($j+1))\) ${list[$j]}	       
		done
	else
		echo "None"
	fi
	
	echo -ne "\n${GREEN}Select a # to run: ${NONE}"
	read choice
	echo

	#bounds checking on menu selection value
	while true
	do
		local l=${#list[@]}
		if [[ $choice =~ ^[0-9]+$ ]] && [[ $choice -le ${#list[@]} ]]; then
			break
		else
			read -p "Invalid selection.  Try again: " choice
		fi
	done
	call_option
        menu	
}

#entry point
echo -e "$BANNER"


#checking for optional args when script was launched
if [[ "$*" == "-h" ]]; then
	help

elif [ -z $1 ]; then	#target IP was not set during launch; prompt for input
	read -p 'Enter target[:port] or -h for help: ' targetIP
	if [ "$targetIP" == "-h" ]; then
		help
	else
		#first prompt for target IP after launch
		ip_check
		if [ $? == 1 ]; then
			printf 'Target has been set as %s\n\n' $targetIP
		else
			echo -e "Invalid target.\n"
			targetIP=null
		fi
		menu
	fi

#user set target IP as arg during launch
elif [ "$#" -eq 1 ]; then
	targetIP=$1
	printf 'Target has been set as %s\n\n' $targetIP
	menu

#user set target IP and module during launch
elif [ "$#" -eq 2 ]; then
	targetIP=$1
	choice=$2
	printf 'Target has been set as %s\n\n' $targetIP
	call_option
else
	help
fi		


