#!/bin/bash
#mkdir results/$1/custom
#nmap -A $1 | tee results/$1/custom/nmap-A.txt
#nmap -sS -sV --script=vuln $1 | tee results/$1/custom/nmap-VULN.txt
#wpscan --url http://$1/wordpress | tee results/$1/wpscan-http.txt
#wpscan --url https://$1/wordpress | tee results/$1/wpscan-https.txt

tmux new-session \; send-keys "nmap -A $1 | tee results/$1/custom/nmap-A.txt" C-m \; split-window -h \; send-keys "nmap -sS -sV --script=vuln $1 | tee results/$1/custom/nmap-VULN.txt" C-m \; split-window -v -p 66 \; send-keys "wpscan --url http://$1/wordpress | tee results/$1/wpscan-http.txt" C-m \; split-window -v \; send-keys "wpscan --url https://$1/wordpress | tee results/$1/wpscan-https.txt" C-m \; select-pane -t 0 \; split-window -v -p 66\; send-keys "nmap -sV --script=nfs-showmount $1 | tee results/$1/NFS-mount.txt" C-m \; split-window -v \; send-keys "nmap -sS -sV --script=exploit $1 | tee results/$1/custom/nmap-EXPLOIT.txt" C-m \;

