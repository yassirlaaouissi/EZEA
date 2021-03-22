#!/bin/bash
#mkdir results/autorecon
#sudo apt install seclists curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap sm>
sudo autorecon -vv -o results/$1/autorecon/ $1 | sudo tee results/$1/autorecon/autorecon_output.txt
