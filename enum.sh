echo "Welcome to EZEA (EaZy Enum Automator), run this as sudo pls"
echo "IP address: $1";


sudo mkdir "results/$1"
sudo mkdir "results/$1/nmapautomator"
sudo mkdir "results/$1/alacarte"
sudo mkdir "results/$1/autorecon"
sudo mkdir "results/$1/custom"

sudo tilix -a app-new-session -t alacarte -x "./alacarte.sh $1" 
sudo tilix -a app-new-session -t nmapautomator -x "./nmapautomator.sh $1"
sudo tilix -a app-new-session -t autorecon -x "./autorecon.sh $1"
sudo tilix -a app-new-session -t custom	-x "./custom.sh $1"

