#!/bin/bash
echo "Welcome to EZEA (EaZy Enum Automator), run this as sudo pls"
echo "IP address: $1";


sudo mkdir "results/$1"
sudo mkdir "results/$1/nmapautomator"
sudo mkdir "results/$1/alacarte"
sudo mkdir "results/$1/autorecon"
sudo mkdir "results/$1/custom"

sudo tilix -a app-new-session -t alacarte -x "/bin/bash -c './alacarte.sh $1'" 
sudo tilix -a app-new-session -t nmapautomator -x "/bin/bash -c './nmapautomator.sh $1'"
sudo tilix -a app-new-session -t autorecon -x "/bin/bash -c './autorecon.sh $1'"
sudo tilix -a app-new-session -t custom	-x "/bin/bash -c './custom.sh $1'"

