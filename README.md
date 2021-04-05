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
3. Run the damn script:

**If bash is your standard shell:**
```
>$ ./runme.sh
Please run as root
Usage: sudo ./runme.sh <IP-Address>
```

**If ZSH is your standard shell:**
```
>$ bash ./runme.sh
Please run as root
Usage: sudo ./runme.sh <IP-Address>
```

It will open some terminal windows, depending on your resources it will run ~30/40 minutes.
After all this hassle it will post the results to the results/<IP-address> folder.


# To-do
1. Make a webpage where all results are pasted and can be exported as PDF, MD, XLSX


