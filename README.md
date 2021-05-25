# Brief explanation
This tool is called EZEA (EaZy Enum Automator), and was made for OSCP. This tool uses bash, tilix and tmux to automate most of the enumeration proces.
This tool uses some already wonderfull enumeration automators and some of my own commands, bundles them in a toolkit, and splits all terminals into terminal tiles. 

Tl;dr: I overachieved my selfmade OSCP Enum script.

# Requirements
- Everything that is in autoinstall.sh

# Installing 

The code within this project relies on the code present within [maurosaria/dirsearch](https://github.com/maurosoria/dirsearch/tree/v0.4.0) to function.
To install the required dependencies the following steps can be followed:

## Automatic

```
$ pwd
~/EZEA
$ sudo ./autoinstall.sh
$ sudo ./runme.sh <IP-address>

```
## Manual
```
$ pwd
~/EZEA
$ sudo git submodule init
$ sudo git submodule update
$ sudo apt install tilix python3 python3-pip dconf-cli dbus-x11
$ sudo python3 -m pip install -r resources/dirsearch/requirements.txt
$ sudo python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git
$ cat /etc/shells
$ sudo chmod +x .
$ sudo ./runme.sh <IP-address>

```


# How to use?
1. Download this repo
2. Install all the dependencies as listed above
3. Run the script
4. Profit?

## Execution

See the example down below

```
>$ ./runme.sh
Please run as root
Usage: sudo ./runme.sh <IP-Address>
```

It will open some terminal windows, depending on your resources it will run ~30/40 minutes.
After all the hassle it will post the results to the results/<IP-address> folder.


# To-do
1. Make a webpage where all results are pasted and can be exported as PDF, MD, XLSX
