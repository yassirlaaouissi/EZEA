# INFO

this is a fork of the original project from [yassirlaaouissi/EZEA](https://github.com/yassirlaaouissi/EZEA) to which I have made some changes.

# Brief explanation
This tool is called EZEA (EaZy Enum Automator), and was made for OSCP. This tool uses bash, tilix and tmux to automate most of the enumeration proces.
This tool uses some already wonderfull enumeration automators and some of my own commands. Bundles them in a toolkit and splits all terminals into terminal tiles. 

Tl;dr: I overachieved my selfmade OSCP Enum script.

# Requirements
- Tilix
- Tmux
- bash or ZSH (Kali 2021 uses ZSH)
- Python3
- The following python3 modules
  - `sudo python3 -m pip install -r resources/dirsearch/requirements.txt`
- The following enumeration script (big upvote to the creators):
  + https://github.com/4ut0m4t0n/alacarte
  + https://github.com/Tib3rius/AutoRecon
  + https://github.com/21y4d/nmapAutomator
- Preferably a kali environment
- git

# Installing dependencies

The code within this project relies on the code present within [maurosaria/dirsearch](https://github.com/maurosoria/dirsearch/tree/v0.4.0) to function.
To install the required dependencies the following steps can be followed:

### initialising

```
EZEA git/master  
% git submodule init                                                             
Submodule 'resources/dirsearch' (git://github.com/maurosoria/dirsearch.git) registered for path 'resources/dirsearch'
```

### Pulling in code

```
EZEA git/master  
% git submodule update
Cloning into '/path/to/project/resources/dirsearch'...
Submodule path 'resources/dirsearch': checked out 'ae36ca7c4d3799c2fffb6a374248c2a974362b2b'
```

# How to use?
1. Download this repo
2. chmod +x all .sh files in the folder, and in the folders folders. And in the folders folders folders folders folders.
3. The following steps are depending on the type of shell you are running. At the time of this writing old kali has bash, new kali has ZSH. This script is based on bash so please check which shell you have. Based on that follow the steps below:

## If bash is your standard shell

see the example down below

```
>$ ./runme.sh
Please run as root
Usage: sudo ./runme.sh <IP-Address>
```

It will open some terminal windows, depending on your resources it will run ~30/40 minutes.
After all this hassle it will post the results to the results/<IP-address> folder.


# To-do
1. Make a webpage where all results are pasted and can be exported as PDF, MD, XLSX
