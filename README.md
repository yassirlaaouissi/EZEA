# Brief explanation
This tool is called EZEA (EaZy Enum Automator), and was made for OSCP. This tool uses bash, tilix and tmux to automate most of the enumeration proces.
This tool uses some already wonderfull enumeration automators and some of my own commands. Bundles them in a toolkit and splits all terminals into terminal tiles. 

Tl;dr: I overachieved my selfmade OSCP Enum script.

# Requirements
- Tilix
- Tmux
- bash or ZSH (Kali 2021 uses ZSH)
- Python3
- The following enumeration script (big upvote to the creators):
  + https://github.com/4ut0m4t0n/alacarte
  + https://github.com/Tib3rius/AutoRecon
  + https://github.com/21y4d/nmapAutomator
- Preferably a kali environment

# How to use?
1. Download this repo
2. chmod +x all .sh files in the folder, and in the folders folders. And in the folders folders folders folders folders.
3. The following steps are depending on the type of shell you are running. At the time of this writing old kali has bash, new kali has ZSH. This script is based on bash so please check which shell you have. Based on that follow the steps below:

## If bash is your standard shell
Just run the damn command you fool, why did you not update your kali :(
```
>$ ./runme.sh
Please run as root
Usage: sudo ./runme.sh <IP-Address>
```

## If ZSH is your standard shell

You have to change your default shell to bash first, else tmux wont recognize bash.
Use the following commands provided by our good friend @pr0b3r7:
1. This command will find the path to bash:
```
>$ type -a bash 
> bash is /usr/bin/bash
> bash is /bin/bash
```
2. This command will change your default shell to bash:
```
>$ chsh -s /bin/bash
```
3. Verify your shell has indeed been changed to /bin/bash:
```
>$ grep "^${USER}" /etc/passwd
> kali:x:1000:1000:kali,,,:/home/kali:/bin/bash
```
4. Finally reboot and run the script again:

```
>$  ./runme.sh
Please run as root
Usage: sudo ./runme.sh <IP-Address>
```

It will open some terminal windows, depending on your resources it will run ~30/40 minutes.
After all this hassle it will post the results to the results/<IP-address> folder.


# To-do
1. Make a webpage where all results are pasted and can be exported as PDF, MD, XLSX


